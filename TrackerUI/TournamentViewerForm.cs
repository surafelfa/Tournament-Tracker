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
        BindingList<int> rounds = new BindingList<int>();
        BindingList<MatchupModel> selectedMatchups = new BindingList<MatchupModel>();

        BindingSource roundsBinding = new BindingSource();
        BindingSource matchupsBinding = new BindingSource();

        public TournamentViewerForm(TournamentModel tournamentModel)
        {
            InitializeComponent();
            tournament = tournamentModel;

            WireUpList();
            //WireUpRoundsLists();
            //WireUpMatchupsLists();

            LoadFormData();
            LoadRounds();
        }
        private void LoadFormData()
        {
            tournamentName.Text = tournament.TournamentName;
        }
        private void WireUpList()
        {
            roundDropDown.DataSource = rounds;
            matchupListBox.DataSource = selectedMatchups;// matchupsBinding;
            matchupListBox.DisplayMember = "DisplayName";
        }
      /*  private void WireUpRoundsLists()
        {
            //roundDropDown.DataSource = null;
           // roundsBinding.DataSource = rounds;
            roundDropDown.DataSource = rounds;// Binding;

        }
        private void WireUpMatchupsLists()
        {
            // matchupListBox.DataSource = null;
           // matchupsBinding.DataSource = selectedMatchups;
            matchupListBox.DataSource = selectedMatchups;// matchupsBinding;
            matchupListBox.DisplayMember = "DisplayName";
        }*/
        private void LoadRounds()
        {
            //rounds = new List<int>();
            rounds.Clear();
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
            LoadMatchups(1);
           // roundsBinding.ResetBindings(false);
           // WireUpRoundsLists();
        }

        private void RoundDropDown_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadMatchups((int)roundDropDown.SelectedItem);
        }
        private void LoadMatchups(int round)
        {
           
            foreach (List<MatchupModel> matchups in tournament.Rounds)
            {
                if (matchups.First().MatchupRound==round)
                {
                    selectedMatchups.Clear();
                    foreach(MatchupModel m in matchups)
                    {
                        selectedMatchups.Add(m);
                    }
                   // selectedMatchups = matchups;
                }
            }
            LoadMatchup(selectedMatchups.First());
           // matchupsBinding.ResetBindings(false);
           // WireUpMatchupsLists();
        }
        private void LoadMatchup(MatchupModel m)
        {
            //MatchupModel m = (MatchupModel)matchupListBox.SelectedItem;

            for (int i = 0; i < m.Entries.Count; i++)
            {
                if (i==0)
                {
                    if (m.Entries[0].TeamCompeting!=null)
                    {
                        teamOneName.Text = m.Entries[0].TeamCompeting.TeamName;
                        teamOneScoreValue.Text = m.Entries[0].Score.ToString();

                        teamTwoName.Text = "<bye>";
                        teamTwoScoreValue.Text = "0";
                    }
                    else
                    {
                        teamOneName.Text = "Not Yet Set";
                        teamOneScoreValue.Text = "0";
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
                        teamTwoScoreValue.Text = "0";
                    }
                }
            }
        }
        private void MatchupListBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if ((MatchupModel)matchupListBox.SelectedItem==null)
            {

            }
            else
            {
                LoadMatchup((MatchupModel)matchupListBox.SelectedItem);
            }
            
        }
    }
}
