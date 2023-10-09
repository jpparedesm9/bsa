Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FTran2696Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializepicVisto()
        InitializeoptOper()
        InitializelblEtiqueta()
        InitializecmdBuscar()
        InitializecmdBoton()
        InitializeOpttipo()
        'This form is an MDI child.
        'This code simulates the Compatibility.VB6 
        ' functionality of automatically
        ' loading and showing an MDI
        ' child's parent.


        'The MDI form in the Compatibility.VB6 project had its
        'AutoShowChildren property set to True
        'To simulate the Compatibility.VB6 behavior, we need to
        'automatically Show the form whenever it
        'is loaded.  If you do not want this behavior
        'then delete the following line of code
        'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
    End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents grdCausas As COBISCorp.Framework.UI.Components.COBISSpread
    Public WithEvents grdCaja As COBISCorp.Framework.UI.Components.COBISSpread
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Private WithEvents _Opttipo_1 As System.Windows.Forms.RadioButton
    Private WithEvents _Opttipo_0 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents cmbTipo As System.Windows.Forms.ComboBox
    Public WithEvents txt_codigo As System.Windows.Forms.TextBox
    Public WithEvents txt_Descripcion As System.Windows.Forms.TextBox
    Private WithEvents _optOper_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optOper_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optOper_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optOper_3 As System.Windows.Forms.RadioButton
    Public WithEvents Frame3D2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public Line1(1) As System.Windows.Forms.Label
    Public Opttipo(1) As System.Windows.Forms.RadioButton
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public cmdBuscar(0) As System.Windows.Forms.Button
    Public lblEtiqueta(4) As System.Windows.Forms.Label
    Public optOper(3) As System.Windows.Forms.RadioButton
    Public picVisto(1) As System.Windows.Forms.PictureBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran2696Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmbTipo = New System.Windows.Forms.ComboBox()
        Me.txt_codigo = New System.Windows.Forms.TextBox()
        Me.txt_Descripcion = New System.Windows.Forms.TextBox()
        Me.grdCausas = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdCausas_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me.grdCaja = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdCaja_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._Opttipo_1 = New System.Windows.Forms.RadioButton()
        Me._Opttipo_0 = New System.Windows.Forms.RadioButton()
        Me.Frame3D2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optOper_1 = New System.Windows.Forms.RadioButton()
        Me._optOper_0 = New System.Windows.Forms.RadioButton()
        Me._optOper_2 = New System.Windows.Forms.RadioButton()
        Me._optOper_3 = New System.Windows.Forms.RadioButton()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TableLayoutPanel3 = New System.Windows.Forms.TableLayoutPanel()
        Me.TableLayoutPanel4 = New System.Windows.Forms.TableLayoutPanel()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel()
        Me.GroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TableLayoutPanel2 = New System.Windows.Forms.TableLayoutPanel()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdCausas, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdCausas_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdCaja, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdCaja_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me.Frame3D2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3D2.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TableLayoutPanel3.SuspendLayout()
        Me.TableLayoutPanel4.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        Me.TableLayoutPanel1.SuspendLayout()
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox2.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TableLayoutPanel2.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'cmbTipo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipo, False)
        Me.cmbTipo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipo, "Default")
        Me.cmbTipo.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbTipo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbTipo.Location = New System.Drawing.Point(99, 10)
        Me.cmbTipo.Name = "cmbTipo"
        Me.cmbTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbTipo.Size = New System.Drawing.Size(149, 21)
        Me.cmbTipo.TabIndex = 1
        Me.ToolTip1.SetToolTip(Me.cmbTipo, "Producto ")
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipo, "")
        '
        'txt_codigo
        '
        Me.txt_codigo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txt_codigo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txt_codigo, False)
        Me.txt_codigo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txt_codigo, "Default")
        Me.txt_codigo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txt_codigo.Location = New System.Drawing.Point(99, 33)
        Me.txt_codigo.MaxLength = 3
        Me.txt_codigo.Name = "txt_codigo"
        Me.txt_codigo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txt_codigo.Size = New System.Drawing.Size(67, 20)
        Me.txt_codigo.TabIndex = 2
        Me.ToolTip1.SetToolTip(Me.txt_codigo, "Codigo de causa")
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txt_codigo, "")
        '
        'txt_Descripcion
        '
        Me.txt_Descripcion.AcceptsReturn = True
        Me.txt_Descripcion.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.txt_Descripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txt_Descripcion, False)
        Me.txt_Descripcion.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txt_Descripcion, "Default")
        Me.txt_Descripcion.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txt_Descripcion.Location = New System.Drawing.Point(99, 56)
        Me.txt_Descripcion.MaxLength = 50
        Me.txt_Descripcion.Name = "txt_Descripcion"
        Me.txt_Descripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txt_Descripcion.Size = New System.Drawing.Size(459, 20)
        Me.txt_Descripcion.TabIndex = 3
        Me.ToolTip1.SetToolTip(Me.txt_Descripcion, "Descripcion de la causa ")
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txt_Descripcion, "")
        '
        'grdCausas
        '
        Me.grdCausas.AccessibleDescription = ""
        Me.grdCausas.AutoClipboard = False
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCausas, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCausas, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdCausas, "Default")
        Me.grdCausas.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdCausas.DAutoSizeCols = COBISCorp.Framework.UI.Components.DAutoSizeColsConstants.DAutoSizeColsNone
        Me.grdCausas.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdCausas.Location = New System.Drawing.Point(3, 16)
        Me.grdCausas.Name = "grdCausas"
        Me.grdCausas.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdCausas_Sheet1})
        Me.grdCausas.Size = New System.Drawing.Size(239, 275)
        Me.grdCausas.StartingColNumber = 1
        Me.grdCausas.StartingRowNumber = 1
        Me.grdCausas.TabIndex = 10
        Me.grdCausas.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeTwips
        Me.grdCausas.VisibleCols = 500
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCausas, "")
        '
        'grdCausas_Sheet1
        '
        Me.grdCausas_Sheet1.Reset()
        Me.grdCausas_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdCausas_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdCausas_Sheet1.DataAutoSizeColumns = False
        Me.grdCausas_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        '
        'grdCaja
        '
        Me.grdCaja.AccessibleDescription = ""
        Me.grdCaja.AutoClipboard = False
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCaja, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCaja, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdCaja, "Default")
        Me.grdCaja.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdCaja.DAutoSizeCols = COBISCorp.Framework.UI.Components.DAutoSizeColsConstants.DAutoSizeColsNone
        Me.grdCaja.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdCaja.Location = New System.Drawing.Point(3, 16)
        Me.grdCaja.Name = "grdCaja"
        Me.grdCaja.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdCaja_Sheet1})
        Me.grdCaja.Size = New System.Drawing.Size(240, 275)
        Me.grdCaja.StartingColNumber = 1
        Me.grdCaja.StartingRowNumber = 1
        Me.grdCaja.TabIndex = 12
        Me.grdCaja.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeTwips
        Me.grdCaja.VisibleCols = 500
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCaja, "")
        '
        'grdCaja_Sheet1
        '
        Me.grdCaja_Sheet1.Reset()
        Me.grdCaja_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdCaja_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdCaja_Sheet1.DataAutoSizeColumns = False
        Me.grdCaja_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(-552, 25)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_0.TabIndex = 22
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Location = New System.Drawing.Point(-566, 25)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 21
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "503336")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_0.TabIndex = 17
        Me._lblEtiqueta_0.Text = "*Descripción :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me._Opttipo_1)
        Me.Frame1.Controls.Add(Me._Opttipo_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(283, 10)
        Me.Frame1.Name = "Frame1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame1, "503332")
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(278, 43)
        Me.Frame1.TabIndex = 25
        Me.Frame1.Text = "*Destino  de Causales"
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        '_Opttipo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Opttipo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Opttipo_1, False)
        Me._Opttipo_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Opttipo_1, "Default")
        Me._Opttipo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Opttipo_1.ForeColor = System.Drawing.Color.Navy
        Me._Opttipo_1.Location = New System.Drawing.Point(164, 20)
        Me._Opttipo_1.Name = "_Opttipo_1"
        Me.COBISResourceProvider.SetResourceID(Me._Opttipo_1, "503334")
        Me._Opttipo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Opttipo_1.Size = New System.Drawing.Size(101, 20)
        Me._Opttipo_1.TabIndex = 15
        Me._Opttipo_1.TabStop = True
        Me._Opttipo_1.Text = "*Data Entry"
        Me._Opttipo_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Opttipo_1, "")
        '
        '_Opttipo_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Opttipo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Opttipo_0, False)
        Me._Opttipo_0.BackColor = System.Drawing.Color.Transparent
        Me._Opttipo_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._Opttipo_0, "Default")
        Me._Opttipo_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Opttipo_0.ForeColor = System.Drawing.Color.Navy
        Me._Opttipo_0.Location = New System.Drawing.Point(60, 20)
        Me._Opttipo_0.Name = "_Opttipo_0"
        Me.COBISResourceProvider.SetResourceID(Me._Opttipo_0, "503333")
        Me._Opttipo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Opttipo_0.Size = New System.Drawing.Size(79, 20)
        Me._Opttipo_0.TabIndex = 4
        Me._Opttipo_0.TabStop = True
        Me._Opttipo_0.Text = "*Caja"
        Me._Opttipo_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Opttipo_0, "")
        '
        'Frame3D2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3D2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3D2, False)
        Me.Frame3D2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3D2.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.Frame3D2.Controls.Add(Me._optOper_1)
        Me.Frame3D2.Controls.Add(Me._optOper_0)
        Me.Frame3D2.Controls.Add(Me._optOper_2)
        Me.Frame3D2.Controls.Add(Me._optOper_3)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3D2, "Default")
        Me.Frame3D2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Frame3D2.ForeColor = System.Drawing.Color.Navy
        Me.Frame3D2.Location = New System.Drawing.Point(3, 3)
        Me.Frame3D2.Name = "Frame3D2"
        Me.Frame3D2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3D2.Size = New System.Drawing.Size(561, 35)
        Me.Frame3D2.TabIndex = 19
        Me.Frame3D2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3D2, "")
        '
        '_optOper_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_1, False)
        Me._optOper_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_1, "Default")
        Me._optOper_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_1.ForeColor = System.Drawing.Color.Navy
        Me._optOper_1.Location = New System.Drawing.Point(153, 34)
        Me._optOper_1.Name = "_optOper_1"
        Me._optOper_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_1.Size = New System.Drawing.Size(124, 20)
        Me._optOper_1.TabIndex = 0
        Me._optOper_1.Tag = "S"
        Me._optOper_1.Text = "*Nota de &Débito:"
        Me._optOper_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_1, "")
        '
        '_optOper_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_0, False)
        Me._optOper_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_0, "Default")
        Me._optOper_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_0.ForeColor = System.Drawing.Color.Navy
        Me._optOper_0.Location = New System.Drawing.Point(30, 34)
        Me._optOper_0.Name = "_optOper_0"
        Me._optOper_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_0.Size = New System.Drawing.Size(124, 20)
        Me._optOper_0.TabIndex = 9
        Me._optOper_0.TabStop = True
        Me._optOper_0.Tag = "S"
        Me._optOper_0.Text = "*Nota de &Crédito:"
        Me._optOper_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_0, "")
        '
        '_optOper_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_2, False)
        Me._optOper_2.BackColor = System.Drawing.Color.Transparent
        Me._optOper_2.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me._optOper_2.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_2, "Default")
        Me._optOper_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_2.ForeColor = System.Drawing.Color.Navy
        Me._optOper_2.Location = New System.Drawing.Point(93, 10)
        Me._optOper_2.Name = "_optOper_2"
        Me.COBISResourceProvider.SetResourceID(Me._optOper_2, "502714")
        Me._optOper_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_2.Size = New System.Drawing.Size(116, 20)
        Me._optOper_2.TabIndex = 13
        Me._optOper_2.TabStop = True
        Me._optOper_2.Tag = "S"
        Me._optOper_2.Text = "*Otros Ingresos:"
        Me._optOper_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_2, "")
        '
        '_optOper_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_3, False)
        Me._optOper_3.BackColor = System.Drawing.Color.Transparent
        Me._optOper_3.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_3, "Default")
        Me._optOper_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_3.ForeColor = System.Drawing.Color.Navy
        Me._optOper_3.Location = New System.Drawing.Point(343, 10)
        Me._optOper_3.Name = "_optOper_3"
        Me.COBISResourceProvider.SetResourceID(Me._optOper_3, "502715")
        Me._optOper_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_3.Size = New System.Drawing.Size(116, 20)
        Me._optOper_3.TabIndex = 14
        Me._optOper_3.Tag = "S"
        Me._optOper_3.Text = "*Otros Egresos:"
        Me._optOper_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_3, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "5048")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_4.TabIndex = 20
        Me._lblEtiqueta_4.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "503335")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_1.TabIndex = 18
        Me._lblEtiqueta_1.Text = "*Código :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 259)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 7
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Limpiar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 310)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 209)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 6
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "2548"
        Me._cmdBoton_1.Text = "*&Crear"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(3, 123)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_2, "2032")
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 54)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 11
        Me._cmdBoton_2.Text = "*&Asignar"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 94)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 5
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.TableLayoutPanel3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(573, 434)
        Me.PFormas.TabIndex = 25
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TableLayoutPanel3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TableLayoutPanel3, False)
        Me.COBISViewResizer.SetAutoResize(Me.TableLayoutPanel3, False)
        Me.TableLayoutPanel3.BackColor = System.Drawing.Color.Transparent
        Me.TableLayoutPanel3.ColumnCount = 1
        Me.TableLayoutPanel3.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel3.Controls.Add(Me.TableLayoutPanel4, 0, 1)
        Me.TableLayoutPanel3.Controls.Add(Me.TableLayoutPanel1, 0, 2)
        Me.TableLayoutPanel3.Controls.Add(Me.Frame3D2, 0, 0)
        Me.COBISStyleProvider.SetControlStyle(Me.TableLayoutPanel3, "Default")
        Me.TableLayoutPanel3.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel3.Location = New System.Drawing.Point(3, 0)
        Me.TableLayoutPanel3.Margin = New System.Windows.Forms.Padding(0)
        Me.TableLayoutPanel3.Name = "TableLayoutPanel3"
        Me.TableLayoutPanel3.RowCount = 3
        Me.TableLayoutPanel3.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel3.RowStyles.Add(New System.Windows.Forms.RowStyle())
        Me.TableLayoutPanel3.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel3.Size = New System.Drawing.Size(567, 431)
        Me.TableLayoutPanel3.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TableLayoutPanel3, "")
        '
        'TableLayoutPanel4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TableLayoutPanel4, False)
        Me.COBISViewResizer.SetAutoResize(Me.TableLayoutPanel4, False)
        Me.TableLayoutPanel4.ColumnCount = 1
        Me.TableLayoutPanel4.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel4.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel4.Controls.Add(Me.UltraGroupBox1, 0, 0)
        Me.COBISStyleProvider.SetControlStyle(Me.TableLayoutPanel4, "Default")
        Me.TableLayoutPanel4.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel4.Location = New System.Drawing.Point(0, 41)
        Me.TableLayoutPanel4.Margin = New System.Windows.Forms.Padding(0)
        Me.TableLayoutPanel4.Name = "TableLayoutPanel4"
        Me.TableLayoutPanel4.RowCount = 1
        Me.TableLayoutPanel4.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel4.Size = New System.Drawing.Size(567, 90)
        Me.TableLayoutPanel4.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TableLayoutPanel4, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me.txt_Descripcion)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me.Frame1)
        Me.UltraGroupBox1.Controls.Add(Me.txt_codigo)
        Me.UltraGroupBox1.Controls.Add(Me.cmbTipo)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(3, 3)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox1.Size = New System.Drawing.Size(561, 84)
        Me.UltraGroupBox1.TabIndex = 26
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'TableLayoutPanel1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TableLayoutPanel1, False)
        Me.COBISViewResizer.SetAutoResize(Me.TableLayoutPanel1, False)
        Me.TableLayoutPanel1.BackColor = System.Drawing.Color.Transparent
        Me.TableLayoutPanel1.ColumnCount = 3
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 44.30619!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 11.38764!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 44.30618!))
        Me.TableLayoutPanel1.Controls.Add(Me.GroupBox2, 2, 0)
        Me.TableLayoutPanel1.Controls.Add(Me.GroupBox1, 0, 0)
        Me.TableLayoutPanel1.Controls.Add(Me.TableLayoutPanel2, 1, 0)
        Me.COBISStyleProvider.SetControlStyle(Me.TableLayoutPanel1, "Default")
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 131)
        Me.TableLayoutPanel1.Margin = New System.Windows.Forms.Padding(0)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 1
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(567, 300)
        Me.TableLayoutPanel1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TableLayoutPanel1, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox2.Controls.Add(Me.grdCaja)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.GroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox2.Location = New System.Drawing.Point(318, 3)
        Me.GroupBox2.Name = "GroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox2, "503338")
        Me.GroupBox2.Size = New System.Drawing.Size(246, 294)
        Me.GroupBox2.TabIndex = 26
        Me.GroupBox2.Text = "*Causales ND/NC  :"
        Me.GroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdCausas)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(3, 3)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "503337")
        Me.GroupBox1.Size = New System.Drawing.Size(245, 294)
        Me.GroupBox1.TabIndex = 25
        Me.GroupBox1.Text = "*Causales ND/NC Generales :"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TableLayoutPanel2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TableLayoutPanel2, False)
        Me.COBISViewResizer.SetAutoResize(Me.TableLayoutPanel2, False)
        Me.TableLayoutPanel2.ColumnCount = 1
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel2.Controls.Add(Me._cmdBoton_2, 0, 2)
        Me.COBISStyleProvider.SetControlStyle(Me.TableLayoutPanel2, "Default")
        Me.TableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel2.Location = New System.Drawing.Point(251, 0)
        Me.TableLayoutPanel2.Margin = New System.Windows.Forms.Padding(0)
        Me.TableLayoutPanel2.Name = "TableLayoutPanel2"
        Me.TableLayoutPanel2.RowCount = 5
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 10.0!))
        Me.TableLayoutPanel2.Size = New System.Drawing.Size(64, 300)
        Me.TableLayoutPanel2.TabIndex = 27
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TableLayoutPanel2, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(593, 25)
        Me.TSBotones.TabIndex = 26
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBCrear
        '
        Me.TSBCrear.ForeColor = System.Drawing.Color.Black
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran2696Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me._picVisto_0)
        Me.Controls.Add(Me._picVisto_1)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Black
        Me.Location = New System.Drawing.Point(15, 119)
        Me.Name = "FTran2696Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(593, 480)
        Me.Text = "Mantenimiento Otros Ingresos-Egresos Caja"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdCausas, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdCausas_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdCaja, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdCaja_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        CType(Me.Frame3D2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3D2.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TableLayoutPanel3.ResumeLayout(False)
        Me.TableLayoutPanel4.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        Me.TableLayoutPanel1.ResumeLayout(False)
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox2.ResumeLayout(False)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TableLayoutPanel2.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializepicVisto()
        Me.picVisto(0) = _picVisto_0
        Me.picVisto(1) = _picVisto_1
    End Sub
    Sub InitializeoptOper()
        Me.optOper(1) = _optOper_1
        Me.optOper(0) = _optOper_0
        Me.optOper(2) = _optOper_2
        Me.optOper(3) = _optOper_3
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBuscar()
        Me.cmdBuscar(0) = _cmdBoton_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub
    Sub InitializeOpttipo()
        Me.Opttipo(1) = _Opttipo_1
        Me.Opttipo(0) = _Opttipo_0
    End Sub

    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents grdCausas_Sheet1 As FarPoint.Win.Spread.SheetView
    Friend WithEvents grdCaja_Sheet1 As FarPoint.Win.Spread.SheetView
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TableLayoutPanel1 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents TableLayoutPanel2 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents TableLayoutPanel3 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents TableLayoutPanel4 As System.Windows.Forms.TableLayoutPanel
    Public WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


