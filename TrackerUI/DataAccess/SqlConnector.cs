using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerUI.Models;

namespace TrackerUI.DataAccess
{
    public class SqlConnector : IDataConnection
    {
        private const string db = "Tournament", password = "0000";
        public PersonModel CreatePerson(PersonModel model)
        {
            string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbo.spPeople_Insert", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FirstName", model.FirstName);
                cmd.Parameters.AddWithValue("@LastName", model.LastName);
                cmd.Parameters.AddWithValue("@EmailAddress", model.EmailAddress);
                cmd.Parameters.AddWithValue("@CellphoneNumber", model.CellPhoneNumber);
                SqlParameter outputParam = new SqlParameter("@id", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outputParam);
                cmd.ExecuteNonQuery();
                model.id = (int)cmd.Parameters["@id"].Value;
                return model;
            }
        }

        // TODO -Make the CreatePrize method actually save to the database
        /// <summary>
        /// saves a new prize to the database
        /// </summary>
        /// <param name="model">the prize information</param>
        /// <returns>the prize information including the unique identifier.</returns>
        public PrizeModel CreatePrize(PrizeModel model)
        {
           string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbo.spPrizes_Insert", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@placeNumber", model.PlaceNumber);
                cmd.Parameters.AddWithValue("@placeName", model.PlaceName);
                cmd.Parameters.AddWithValue("@prizeAmount", model.PrizeAmount);
                cmd.Parameters.AddWithValue("@prizePercentage", model.PrizePercentage);
                SqlParameter outputParam = new SqlParameter("@id", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outputParam);
                cmd.ExecuteNonQuery();
                model.id = (int)cmd.Parameters["@id"].Value;
                return model;
            }
            
            /*using (IDbConnection connection = new System.Data.SqlClient.SqlConnection(GlobalConfig.CnnString("Tournament")))
            {
                var p = new DynamicParameters();
                p.Add("@placeNumbe", model.PlaceNumber);
                p.Add("@placeName", model.PlaceName);
                p.Add("@prizeAmount", model.PrizeAmount);
                p.Add("@prizePercentage", model.PrizePercentage);
                p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);
                connection.Execute("dbo.spPrizes_Insert", p,commandType: CommandType.StoredProcedure);

                model.id = p.Get<int>("@id");
                return model;
            }*/

        }

        public TeamModel CreateTeam(TeamModel model)
        {
            string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("dbo.spTeams_Insert", con);
                //var p = new DynamicParameters();
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TeamName", model.TeamName);
                SqlParameter outputParam = new SqlParameter("@id", SqlDbType.Int);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outputParam);
                cmd.ExecuteNonQuery();
                model.id = (int)cmd.Parameters["@id"].Value;
                foreach(PersonModel tm in model.TeamMembers)
                {
                    cmd = new SqlCommand("dbo.spTeamMembers_Insert", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TeamId", model.id);
                    cmd.Parameters.AddWithValue("@PersonId",tm.id );
                    cmd.ExecuteNonQuery();
                }
                return model;
            }
        }

        public void CreateTournament(TournamentModel model)
        {
            string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SaveTournament(con, model);

                SaveTournamentPrizes(con, model);

                SaveTournamentEntries(con, model);

                SaveTournamentRounds(con, model);
               
                //return model;
            }
        }
        private void SaveTournament(SqlConnection con,TournamentModel model)
        {
            var p = new DynamicParameters();
            p.Add("@TournamentName", model.TournamentName);
            p.Add("@EnrtyFee", model.EntryFee);
            p.Add("id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

            con.Execute("spTournaments_Insert", p, commandType: CommandType.StoredProcedure);

            model.id = p.Get<int>("@id");
        }
        private void SaveTournamentPrizes(SqlConnection con, TournamentModel model)
        {
            var p = new DynamicParameters();
            foreach (PrizeModel pz in model.Prizes)
            {
                p = new DynamicParameters();
                p.Add("@TournamentId", model.id);
                p.Add("@PrizeId", pz.id);
                p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                con.Execute("spTournamentPrizes_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
        private void SaveTournamentEntries(SqlConnection con,TournamentModel model)
        {
           var p = new DynamicParameters();
            foreach (TeamModel tm in model.EnteredTeams)
            {
                p = new DynamicParameters();
                p.Add("@TournamentId", model.id);
                p.Add("@TeamId", tm.id);
                p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                con.Execute("spTournamentEntries_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
        private void SaveTournamentRounds(SqlConnection con, TournamentModel model)
        {
            foreach(List<MatchupModel> round in model.Rounds)
            {
                foreach(MatchupModel matchup in round)
                {
                    var p = new DynamicParameters();
                    p.Add("@TournamentId", model.id);
                    p.Add("@MatchupRound", matchup.MatchupRound);
                    p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                    con.Execute("spMatchups_Insert",p,commandType: CommandType.StoredProcedure);

                    matchup.id = p.Get<int>("@id");

                    foreach (MatchupEntryModel entry in matchup.Entries)
                    {
                        p = new DynamicParameters();

                        p.Add("@MatchupId", matchup.id);
                        

                        if (entry.ParentMatchup == null)
                        {
                            p.Add("@ParentMatchupId",  null);
                        }
                        else
                        {
                            p.Add("@ParentMatchupId", entry.ParentMatchup.id);
                        }
                        if (entry.TeamCompeting==null)
                        {
                            p.Add("@TeamCompetingId", null);
                        }
                        else
                        {
                            p.Add("@TeamCompetingId", entry.TeamCompeting.id);
                        }
                        p.Add("@id", 0, dbType: DbType.Int32, direction: ParameterDirection.Output);

                        con.Execute("spMatchupEntries_Insert", p, commandType: CommandType.StoredProcedure);
                    }
                }
                
                
            }
        }
        public List<PersonModel> GetPerson_All()
        {
            string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            List<PersonModel> output;
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                output = con.Query<PersonModel>("dbo.spPeople_GetAll").ToList();
            }
            return output;
        }

        public List<TeamModel> GetTeam_All()
        {
            string constr = "Server=.;database=Tournament;uid=sur;pwd=0000;";
            List<TeamModel> output;
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                output = con.Query<TeamModel>("spTeam_GetAll").ToList();
                foreach(TeamModel team in output)
                {
                    var p = new DynamicParameters();
                    p.Add("@TeamId", team.id);
                    team.TeamMembers = con.Query<PersonModel>("spTeamMembers_GetByTeam", p, commandType: CommandType.StoredProcedure).ToList();
                }
               
            }
            return output;

        }
    }
}
