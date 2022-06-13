// See https://aka.ms/new-console-template for more information
using DB;

var dbService = new DataBaseService();
dbService.OpenConnection();

dbService.ClearData();

dbService.AddClient(out _, "Client 1", "Region", "City", "Address", "NIP");
dbService.AddClient(out _, "Client 2", "Region", "City", "Address", "NIP");

var days = new List<DataBaseService.DayList>()
{
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-07-14"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-07-15"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-07-16"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-07-17"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-07-18"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },

};
dbService.AddConference(out _, "Conf 1", days, 100, 2034.5f, "Region", "City", "Address");

days = new List<DataBaseService.DayList>()
{
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-08-14"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-08-15"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },

};
dbService.AddConference(out _, "Conf 2", days, 200, 1000, "Region", "City", "Address");

days = new List<DataBaseService.DayList>()
{
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-09-14"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-09-15"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-09-16"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },
    new DataBaseService.DayList() { Date = DateTime.Parse("2022-09-17"), StartTime = TimeSpan.Parse("12:00:00"), FinishTime = TimeSpan.Parse("17:00:00") },

};
dbService.AddConference(out _, "Conf 3", days, 70, 10000, "Region", "City", "Address");

for (int i = 0; i < 11; i++)
    AddWorkshops(2, 30, i + 1);

AddParticipant(500);
AddReservationsConference(200, 11, 2);
AddReservationWorkshop(300, 22, 2);
AddConferenceParticipants(200);

for (int i = 0; i < 10; i++)
    AddWorkshopParticipants(200, 201);

for (int i = 0; i < 10; i++)
    MakePayments(500);


void AddWorkshops(int count, int capacity, int cdId)
{
    for (int i = 0; i < count; i++)
        dbService.AddWorkshop(out _, "W 1", TimeSpan.Parse("13:00:00"), TimeSpan.Parse("16:00:00"), capacity, 1000, "Reg", "City", "Add", cdId);
}

void AddParticipant(int count)
{
    for (int i = 0; i < count; i++)
        dbService.AddParticipant(out _, RandomString(5), RandomString(5), "Reg", "City", "Add", DateTime.Now);
}

void AddReservationsConference(int count, int cdCount, int clientCount)
{
    for (int i = 0; i < count; i++)
        dbService.AddReservation(out _, new Random().Next(1, cdCount), null, new Random().Next(1, clientCount + 1));
}

void AddReservationWorkshop(int count, int wCount, int clientCount)
{
    for (int i = 0; i < count; i++)
        dbService.AddReservation(out _, null, new Random().Next(1, wCount), new Random().Next(1, clientCount + 1));
}

void AddConferenceParticipants(int count)
{
    for (int i = 0; i < count; i++)
        dbService.AddConferenceParticipant(out _, i + 1, i + 14);
}

void AddWorkshopParticipants(int count, int resStart)
{
    for (int i = 0; i < count; i++)
        dbService.AddWorkshopParticipant(out _, new Random().Next(1, count), resStart + i);
}

void MakePayments(int count)
{
    for (int i = 0; i < count; i++)
        dbService.MakePayment(out _, new Random().Next(1, 100), new Random().Next(0, count), DateTime.Now);
}

dbService.CloseConnection();

string RandomString(int length)
{
    const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return new string(Enumerable.Repeat(chars, length)
        .Select(s => s[new Random().Next(s.Length)]).ToArray());
}