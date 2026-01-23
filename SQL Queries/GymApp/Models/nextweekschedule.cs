using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class nextweekschedule
{
    public int? class_id { get; set; }

    public string? class_name { get; set; }

    public DateTime? start_time { get; set; }

    public int? capacity { get; set; }

    public long? booked_spots { get; set; }

    public decimal? occupancy_percent { get; set; }
}
