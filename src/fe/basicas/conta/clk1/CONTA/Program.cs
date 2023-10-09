using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace CONTA
{
    static class Program
    {
        [STAThread]
        static void Main()
        {
            COBISCorp.eCOBIS.COBISExplorer.Deployment.COBISBaseApplication.RegisterLocation("CONTA.MXN.Reports.Installer", "COBISExplorer");
        }
    }
}
