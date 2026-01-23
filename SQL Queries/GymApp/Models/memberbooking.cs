using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class memberbooking
{
    public int? booking_id { get; set; }

    public int? member_id { get; set; }

    public int? class_id { get; set; }

    public string? class_name { get; set; }

    public DateTime? start_time { get; set; }

    public string? booking_status { get; set; }
}
