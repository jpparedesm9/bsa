using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using COBISCorp.eCOBIS.COBISExplorer.CompositeUI;

namespace COBISCorp.tCOBIS.CON.ToolBar
{
    public class ToolBar : ICOBISToolBar
    {
        public void Add(string[] groups)
        {
            //Se agrega el RibbonTab
            if (!COBISMenu.ExistsMenu("mnuHerramienta"))
                COBISMenu.AddMenu("mnuHerramienta", "ToolBar con Grupos");
            else
                COBISMenu.ShowMenu("mnuHerramienta");
            int i = 1;
            COBISMenu.HideGroups("mnuHerramienta");
            foreach (string group in groups)
            {
                //Se agrega los grupos especificados en el atributo COBISToolBarAttribute                
                if (!COBISMenu.ExistsGroup(group, "mnuHerramienta"))
                {
                    //si no existe el grupo se lo crea
                    COBISMenu.AddGroup(group, "Grupo " + i, "mnuHerramienta", COBISCorp.eCOBIS.COBISExplorer.CompositeUI.EnumAlignment.Center, COBISCorp.eCOBIS.COBISExplorer.CompositeUI.EnumDirection.Vertical);
                    i++;
                }
                else//si el grupo ya existe simplemente se lo muestra
                    COBISMenu.ShowGroup("mnuHerramienta", group);
            }
            //Se establece el foco al menú creado
            COBISMenu.GetRibbon().SelectedTab = COBISMenu.GetRibbonTab("mnuHerramienta");

        }

        public void Add()
        {
            if (COBISMenu.ExistsMenu("mnuHerramienta") == false)
            {
                COBISMenu.AddMenu("mnuHerramienta", "Barra de Herramientas");
                if (COBISMenu.ExistsGroup("gprHerramienta", "MonolithicMenu") == false)
                {
                    COBISMenu.AddGroup("gprHerramienta", "Contabilidad", "mnuHerramienta", EnumAlignment.Center, EnumDirection.Horizontal);
                    if (COBISMenu.ExistsTool("cmbEmpresa", "gprHerramienta") == false)
                    {
                        COBISMenu.AddComboBoxTool("Empresa", "cmbEmpresa", "gprHerramienta", EnumSize.Default, EnumStyle.Default);
                    }
                }

            }
        }

        public void Hide()
        {
            COBISMenu.HideMenu("mnuHerramienta");
        }

        public void Remove()
        {
            //se debe eliminar el tool y el CommandHandler
            //COBISMenu.RemoveTool("btnPrueba", "ManejadorBtnPrueba", "gprHerramienta");
            COBISMenu.RemoveMenu("mnuHerramienta");

        }

        public void Show(string[] groups)
        {
            COBISMenu.ShowGroup("mnuHerramienta", groups);
            //Se establece el foco al menú que se está mostrando en el Ribbon
            COBISMenu.GetRibbon().SelectedTab = COBISMenu.GetRibbonTab("mnuHerramienta");

        }

        public void Show()
        {
            COBISMenu.ShowMenu("mnuHerramienta");
            //Se establece el foco al menú que se está mostrando en el Ribbon
            COBISMenu.GetRibbon().SelectedTab = COBISMenu.GetRibbonTab("mnuHerramienta");

        }
    }
}
