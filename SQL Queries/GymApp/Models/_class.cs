using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class _class
{
    public int class_id { get; set; }

    public string class_name { get; set; } = null!;

    public DateTime start_time { get; set; }

    public int? capacity { get; set; }

    public int? trainer_id { get; set; }

    public virtual ICollection<booking> bookings { get; set; } = new List<booking>();

    public virtual trainer? trainer { get; set; }
}
