using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class subscription
{
    public int sub_id { get; set; }

    public DateOnly start_date { get; set; }

    public DateOnly end_date { get; set; }

    public string? status { get; set; }

    public int member_id { get; set; }

    public int plan_id { get; set; }

    public virtual member member { get; set; } = null!;

    public virtual membersship_plan plan { get; set; } = null!;
}
