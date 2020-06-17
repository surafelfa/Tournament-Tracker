using System;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using TrackerUI.DataAccess;

namespace TrackerUI
{
    public static class GlobalConfig
    {
        public static IDataConnection Connection { get; private set; }
        public static void InitializeConncetions(DatabaseType db)
        {

            if (db== DatabaseType.sql)
            {
                //TODO -Create the sql connection
                SqlConnector sql = new SqlConnector();
                Connection=sql;

            }
            if (db==DatabaseType.TextFile)
            {
                //TODO -Create the text conncetion
                TextConnector text = new TextConnector();
                Connection=text;
            }
        }
        public static string CnnString(string name)
        {
           return  ConfigurationManager.ConnectionStrings[name].ConnectionString;
        }
    }
}
