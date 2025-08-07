# The Snowpark package is required for Python Worksheets. 
# You can add more packages by selecting them using the Packages control and then importing them.
import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import col
import pandas as pd
import yaml
from constant_and_util import *

def main(session: snowpark.Session):

    result=session.sql(TEST_QUERY).collect()
    
    return "SUCCESS"