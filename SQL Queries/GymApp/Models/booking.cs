using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class booking
{
    public int booking_id { get; set; }

    public DateTime? booking_date { get; set; }

    public string status { get; set; } = null!;

    public int member_id { get; set; }

    public int class_id { get; set; }

    public virtual _class _class { get; set; } = null!;

    public virtual member member { get; set; } = null!;

    public virtual ICollection<payment> payments { get; set; } = new List<payment>();
}
