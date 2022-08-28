using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DB
{
    internal sealed class DataBaseService
    {
        private readonly string connectionString = @"Server=*****;Database=*****;User Id=*****;Password=*****;";
        private SqlConnection conn;

        public void OpenConnection()
        {
            conn = new SqlConnection(connectionString);
            conn.Open();
        }

        public void CloseConnection()
        {
            conn.Close();
        }

        public bool AddClient(out string errorMsg, string clientName, string region, string city, string address, string NIP)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddClient", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("ClientName", clientName));
                cmd.Parameters.Add(new("Region", region));
                cmd.Parameters.Add(new("City", city));
                cmd.Parameters.Add(new("Address", address));
                cmd.Parameters.Add(new("NIP", NIP));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddConference(out string errorMsg, string name, List<DayList> days, int capacity, float price, string region, string city, string address)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddConference", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("Name", name));
                cmd.Parameters.Add(new("Region", region));
                cmd.Parameters.Add(new("Capacity", capacity));
                cmd.Parameters.Add(new("Price", price));
                cmd.Parameters.Add(new("Address", address));
                cmd.Parameters.Add(new("City", city));

                cmd.Parameters.Add(new("Days", SqlDbType.Structured));
                IEnumerable<SqlDataRecord> enumerable = days.Select((c, i) => c.ToSqlDataRecord(i + 1));
                var a = enumerable.ToList();
                cmd.Parameters["Days"].Value = enumerable;
                cmd.Parameters["Days"].TypeName = "dbo.DayList";

                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddConferenceParticipant(out string errorMsg, int participantId, int reservationId)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddConferenceParticipant", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("ParticipantId", participantId));
                cmd.Parameters.Add(new("ReservationId", reservationId));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddParticipant(out string errorMsg, string fn, string ln, string reg, string city, string add, DateTime bd)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddParticipant", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("FirstName", fn));
                cmd.Parameters.Add(new("LastName", ln));
                cmd.Parameters.Add(new("Region", reg));
                cmd.Parameters.Add(new("City", city));
                cmd.Parameters.Add(new("Address", add));
                cmd.Parameters.Add(new("BirthDate", bd));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddReservation(out string errorMsg, int? cdId, int? wId, int clientId)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddReservation", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("ConferenceDayId", (object)cdId ?? DBNull.Value));
                cmd.Parameters.Add(new("WorkshopId", (object)wId ?? DBNull.Value));
                cmd.Parameters.Add(new("ClientId", clientId));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddWorkshop(out string errorMsg, string name, TimeSpan sTime, TimeSpan fTime, int capacity, int price, string region, string city, string address, int cdId)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddWorkshop", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("Name", name));
                cmd.Parameters.Add(new("StartTime", sTime));
                cmd.Parameters.Add(new("FinishTime", fTime));
                cmd.Parameters.Add(new("Capacity", capacity));
                cmd.Parameters.Add(new("Price", price));
                cmd.Parameters.Add(new("Region", region));
                cmd.Parameters.Add(new("City", city));
                cmd.Parameters.Add(new("Address", address));
                cmd.Parameters.Add(new("ConferenceDayId", cdId));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool AddWorkshopParticipant(out string errorMsg, int cpId, int reservationId)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.AddWorkshopParticipant", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("ConferenceParticipant", cpId));
                cmd.Parameters.Add(new("ReservationId", reservationId));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool MakePayment(out string errorMsg, int amount, int reservationId, DateTime date)
        {
            try
            {
                using var cmd = new SqlCommand("dbo.MakePayment", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new("Amount", amount));
                cmd.Parameters.Add(new("ReservationId", reservationId));
                cmd.Parameters.Add(new("Date", date));
                cmd.Parameters.Add("Result", SqlDbType.VarChar, 50).Direction = ParameterDirection.Output;

                var resCode = cmd.ExecuteNonQuery();
                errorMsg = (string)cmd.Parameters["Result"].Value;
                return resCode == 0;
            }
            catch (Exception ex)
            {
                errorMsg = ex.Message;
                return false;
            }
        }

        public bool ClearData()
        {
            try
            {
                using var cmd = new SqlCommand("debug.RecreateTables", conn);

                var resCode = cmd.ExecuteNonQuery();
                return resCode == 0;
            }
            catch
            {
                return false;
            }
        }

        public SqlDataReader ExecuteQuery(string query)
        {
            using var cmd = new SqlCommand(query, conn);
            var reader = cmd.ExecuteReader();
            return reader;
        }


        public class DayList
        {
            public DateTime Date { get; set; }
            public TimeSpan StartTime { get; set; }
            public TimeSpan FinishTime { get; set; }

            private static readonly SqlMetaData[] myRecordSchema = {
                new SqlMetaData("Id", SqlDbType.Int),
                new SqlMetaData("Date", SqlDbType.Date),
                new SqlMetaData("Start Time", SqlDbType.Time),
                new SqlMetaData("Finish Time", SqlDbType.Time)
            };

            public SqlDataRecord ToSqlDataRecord(int id)
            {
                var record = new SqlDataRecord(myRecordSchema);
                record.SetInt32(0, id);
                record.SetDateTime(1, Date);
                record.SetTimeSpan(2, StartTime);
                record.SetTimeSpan(3, FinishTime);
                return record;
            }
        }
    }
}
