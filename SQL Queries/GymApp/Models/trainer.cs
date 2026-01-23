using System;
using System.Collections.Generic;

namespace GymApp.Models;

public partial class trainer
{
    public int trainer_id { get; set; }

    public string name { get; set; } = null!;

    public string email { get; set; } = null!;

    public string speciality { get; set; } = null!;

    public bool? isactive { get; set; }

    public virtual ICollection<_class> _classes { get; set; } = new List<_class>();
}
