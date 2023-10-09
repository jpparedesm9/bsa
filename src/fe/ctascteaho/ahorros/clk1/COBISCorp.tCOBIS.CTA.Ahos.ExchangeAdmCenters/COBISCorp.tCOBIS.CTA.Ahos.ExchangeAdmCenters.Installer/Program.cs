using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace COBISCorp.tCOBIS.CTA.Ahos.ExchangeAdmCenters.Installer
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            COBISCorp.eCOBIS.COBISExplorer.Deployment.COBISBaseApplication.RegisterLocation("CTA.Ahos.ExchangeAdmCenters.Installer", "COBISExplorer");
        }
    }
}