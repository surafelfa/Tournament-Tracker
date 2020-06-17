using System;
using System.Collections.Generic;
using System.Text;
using TrackerLibrary.DataAccess;
using TrackerLibrary.Models;

namespace TrackerLibrary
{
    public static class GlobalConfig
    {
        public static List<IDataConnection> Connections { get; private set; } = new List<IDataConnection>();
        public static void InitializeConncetions(bool database, bool textFiles)
        {
            if (database)
            {
                //TODO -Create the sql connection
                SqlConnector sql = new SqlConnector();
                Connections.Add(sql);

            }
            if (textFiles)
            {
                //TODO -Create the text conncetion
                TextConnector text = new TextConnector();
                Connections.Add(text);
            }
        }
    }
}
