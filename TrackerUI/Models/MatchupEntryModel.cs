using System;
using System.Collections.Generic;
using System.Text;

namespace TrackerUI.Models
{
    /// <summary>
    /// Represents one team in a mathup
    /// </summary>
    public class MatchupEntryModel
    {
        public int id { get; set; }
        /// <summary>
        /// the unique identifier for the team.
        /// </summary>
        public int TeamCompetingId { get; set; }
        /// <summary>
        /// Reprensents one team in the match
        /// </summary>
        public TeamModel TeamCompeting { get; set; }
        /// <summary>
        /// Represents the score for this particular team
        /// </summary>
        public double Score { get; set; }
        /// <summary>
        /// the unique identifier for the parent matchup (team)
        /// </summary>
        public int ParentMatchupId { get; set; }
        /// <summary>
        /// Represents the matchup that this team came from as winner
        /// </summary>
        public MatchupModel ParentMatchup { get; set; }
    }
}
