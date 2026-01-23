using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class membersship_plan
{
    public int plan_id { get; set; }

    public string plan_name { get; set; } = null!;

    public decimal? price { get; set; }

    public int duration { get; set; }

    public bool? isactive { get; set; }

    public virtual ICollection<subscription> subscriptions { get; set; } = new List<subscription>();
}
