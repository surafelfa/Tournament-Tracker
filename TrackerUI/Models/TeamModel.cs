using System;
using System.Collections.Generic;
using System.Text;

namespace TrackerUI.Models
{
    public class TeamModel
    {
        public int id{ get; set; }
        public string TeamName { get; set; }
        public List<PersonModel> TeamMembers { get; set; } = new List<PersonModel>();
      
    }
}
