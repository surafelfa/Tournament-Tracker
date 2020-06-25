using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TrackerUI.Models;

namespace TrackerUI
{
    public partial class TournamentViewerForm: Form
    {
        private TournamentModel tournament;
        List<int> rounds = new List<int>();
        List<MatchupModel> selectedMatchups = new List<MatchupModel>();
        public TournamentViewerForm(TournamentModel tournamentModel)
        {
            InitializeComponent();
            tournament = tournamentModel;
            LoadFormData();
            LoadRounds();
        }
        private void LoadFormData()
        {
            tournamentName.Text = tournament.TournamentName;
        }
        private void WireUpRoundsLists()
        {
            roundDropDown.DataSource = null;
            roundDropDown.DataSource = rounds;

        }
        private void WireUpMatchupsLists()
        {
            //matchupListBox.DataSource = null;
            matchupListBox.DataSource = selectedMatchups;
            matchupListBox.DisplayMember = "DisplayName";
        }
        private void LoadRounds()
        {
            rounds = new List<int>();
            rounds.Add(1);
            int currRound = 1;
            foreach(List<MatchupModel>matchups in tournament.Rounds)
            {
                if (matchups.First().MatchupRound > currRound)
                {
                    currRound = matchups.First().MatchupRound;
                    rounds.Add(currRound);
                }
            }
            WireUpRoundsLists();
        }

        private void RoundDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMatchups();
        }
        private void LoadMatchups()
        {
            int round = (int)roundDropDown.SelectedItem;
            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {
                if (matchups.First().MatchupRound==round)
                {
                    selectedMatchups = matchups;
                }
            }
            WireUpMatchupsLists();
        }
        private void LoadMatchup()
        {
            MatchupModel m = (MatchupModel)matchupListBox.SelectedItem;
            //int x = (int)m.Entries.Count;
            for (int i = 0; i < m.Entries.Count; i++)
            {
                if (i==0)
                {
                    if (m.Entries[0].TeamCompeting!=null)
                    {
                        teamOneName.Text = m.Entries[0].TeamCompeting.TeamName;
                        teamOneScoreValue.Text = m.Entries[0].Score.ToString();
                    }
                    else
                    {
                        teamOneName.Text = "Not Yet Set";
                    }
                }
                if (i == 1)
                {
                    if (m.Entries[1].TeamCompeting != null)
                    {
                        teamTwoName.Text = m.Entries[1].TeamCompeting.TeamName;
                        teamTwoScoreValue.Text = m.Entries[1].Score.ToString();
                    }
                    else
                    {
                        teamTwoName.Text = "Not Yet Set";
                    }
                }
            }
        }
        private void MatchupListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMatchup();
        }
    }
}
