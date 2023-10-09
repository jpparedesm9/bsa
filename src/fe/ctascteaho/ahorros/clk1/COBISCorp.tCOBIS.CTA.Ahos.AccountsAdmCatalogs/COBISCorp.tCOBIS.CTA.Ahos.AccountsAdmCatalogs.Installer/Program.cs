using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;

namespace COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs.Installer
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            COBISCorp.eCOBIS.COBISExplorer.Deployment.COBISBaseApplication.RegisterLocation("CTA.Ahos.AccountsAdmCatalogs.Installer", "COBISExplorer");
        }
    }
}
