using System;
using System.Collections.Generic;
using System.Text;

namespace TrackerUI.Models
{
    /// <summary>
    /// Represents one match in the tournament.
    /// </summary>
    public class MatchupModel
    {
        
        public int id { get; set; }
        /// <summary>
        /// The set of teams that were involved in this match
        /// </summary>
        public List<MatchupEntryModel> Entries { get; set; }= new List<MatchupEntryModel>();
        /// <summary>
        /// the id from the database that will be used to identify the winner
        /// </summary>
        public int WinnerId { get; set; }
        /// <summary>
        /// The winner of the match
        /// </summary>
        public TeamModel Winner { get; set; }
        /// <summary>
        /// Which round this match is a part of.
        /// </summary>
        public int MatchupRound { get; set; }
        public string DisplayName {
            get
            {
                string output = "";
                foreach(MatchupEntryModel me in Entries)
                {
                    if (me.TeamCompeting!=null)
                    {
                        if (output.Length == 0)
                        {
                            output = me.TeamCompeting.TeamName;
                        }
                        else
                        {
                            output += $" vs. {me.TeamCompeting.TeamName}";
                        } 
                    }
                    else
                    {
                        output = "Matchup Not Yet Determined";
                        break;
                    }
                }
                return output;
            }
        }
    }
}
