import subprocess
import sys
import datetime

from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import serialization
from snowflake.snowpark import Session


def read_pkb_key(path,password):
    with open(f"{path}", "rb") as key:
        private_key = serialization.load_pem_private_key(
            key.read(),
            password=password.encode(),
            backend=default_backend()
        )


    pkb = private_key.private_bytes(
        encoding=serialization.Encoding.DER,
        format=serialization.PrivateFormat.PKCS8,
        encryption_algorithm=serialization.NoEncryption()
    )


    return pkb


def create_snowpark_session(connection_parameters):
    session = Session.builder.configs(connection_parameters).create()
    return session


def log_debug_message(log_file_path,message):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open(log_file_path, "a") as f:
        f.write(f"[{timestamp}] {message}\n")
    # Also print to stderr for immediate feedback in the terminal where the hook runs
    sys.stderr.write(f"[{timestamp}] {message}\n")

def run_git_command(command_args):
    """
    Helper function to run a git command and return its output.
    Raises an exception if the command fails.
    """
    try:
        result = subprocess.run(
            command_args,
            capture_output=True,
            text=True,
            check=True,  # This will raise a CalledProcessError if the command returns a non-zero exit code
            encoding='utf-8' # Ensure consistent encoding for output
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        sys.stderr.write(f"Error running git command: {' '.join(command_args)}\n")
        sys.stderr.write(f"STDOUT: {e.stdout}\n")
        sys.stderr.write(f"STDERR: {e.stderr}\n")
        # For a post-commit hook, it's often better to exit gracefully (0)
        # unless the error is critical and should abort the shell process.
        # If you want the commit to fail, use a pre-commit hook.
        sys.exit(0)
    except FileNotFoundError:
        sys.stderr.write(f"Error: 'git' command not found. Make sure Git is installed and in your PATH.\n")
        sys.exit(1)


def get_current_branch():
    """
    Gets the name of the current active branch.
    Returns None if in a detached HEAD state.
    """
    try:
        branch_name = run_git_command(["git", "rev-parse", "--abbrev-ref", "HEAD"])
        if branch_name == "HEAD": # Indicates detached HEAD
            return None
        return branch_name
    except Exception as e:
        sys.stderr.write(f"Error getting current branch: {e}\n")
        return None
