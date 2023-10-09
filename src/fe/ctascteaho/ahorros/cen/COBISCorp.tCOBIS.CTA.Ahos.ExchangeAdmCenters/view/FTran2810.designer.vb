Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTran2810Class

#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializepicVisto()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        InitializeSSCheck1()
        'InitializeLine1()
        InitializeFrame4()
        InitializeFrame1()
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
    Private WithEvents _picVisto_5 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_4 As System.Windows.Forms.PictureBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _SSCheck1_0 As System.Windows.Forms.CheckBox
    Public WithEvents grdPagos As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_12 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_16 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_13 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_15 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_21 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_20 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_19 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Public WithEvents Frame3 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents txtDesc As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _Frame4_0 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_14 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Public WithEvents lblSecuencial As System.Windows.Forms.Label
    Private WithEvents _Frame1_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _MhTab1_TabPage0 As System.Windows.Forms.TabPage
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _Frame4_1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_10 As System.Windows.Forms.Button
    Public WithEvents grdOfiCanje As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_9 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_8 As System.Windows.Forms.Button
    Public WithEvents Frame2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _MhTab1_TabPage1 As System.Windows.Forms.TabPage
    Public WithEvents MhTab1 As COBISCorp.Framework.UI.Components.COBISTabControl
    Public Frame1(0) As Infragistics.Win.Misc.UltraGroupBox
    Public Frame4(1) As Infragistics.Win.Misc.UltraGroupBox
    Public Line1(2) As System.Windows.Forms.Label
    Public SSCheck1(0) As System.Windows.Forms.CheckBox
    Public cmdBoton(16) As System.Windows.Forms.Button
    Public lblDescripcion(14) As System.Windows.Forms.Label
    Public lblEtiqueta(21) As System.Windows.Forms.Label
    Public picVisto(5) As System.Windows.Forms.PictureBox
    Public txtCampo(5) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran2810Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.MhTab1 = New COBISCorp.Framework.UI.Components.COBISTabControl()
        Me._MhTab1_TabPage0 = New System.Windows.Forms.TabPage()
        Me._Frame1_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New System.Windows.Forms.GroupBox()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._Frame4_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtDesc = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me.lblSecuencial = New System.Windows.Forms.Label()
        Me._MhTab1_TabPage1 = New System.Windows.Forms.TabPage()
        Me.Frame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New System.Windows.Forms.GroupBox()
        Me.grdOfiCanje = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._Frame4_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_10 = New System.Windows.Forms.Button()
        Me._cmdBoton_9 = New System.Windows.Forms.Button()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me._cmdBoton_8 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_14 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me.Frame3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._picVisto_5 = New System.Windows.Forms.PictureBox()
        Me._picVisto_4 = New System.Windows.Forms.PictureBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._SSCheck1_0 = New System.Windows.Forms.CheckBox()
        Me.grdPagos = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_12 = New System.Windows.Forms.Button()
        Me._cmdBoton_16 = New System.Windows.Forms.Button()
        Me._cmdBoton_13 = New System.Windows.Forms.Button()
        Me._cmdBoton_15 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_21 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_20 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_19 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBBuscar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBModificar = New System.Windows.Forms.ToolStripButton()
        Me.TSBModificar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.MhTab1.SuspendLayout()
        Me._MhTab1_TabPage0.SuspendLayout()
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame1_0.SuspendLayout()
        Me.GroupBox1.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_0.SuspendLayout()
        Me._MhTab1_TabPage1.SuspendLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame2.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        CType(Me.grdOfiCanje, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_1.SuspendLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3.SuspendLayout()
        CType(Me._picVisto_5, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_4, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdPagos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        'MhTab1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.MhTab1, False)
        Me.COBISViewResizer.SetAutoResize(Me.MhTab1, False)
        Me.MhTab1.Controls.Add(Me._MhTab1_TabPage0)
        Me.MhTab1.Controls.Add(Me._MhTab1_TabPage1)
        Me.COBISStyleProvider.SetControlStyle(Me.MhTab1, "Default")
        Me.MhTab1.DrawMode = System.Windows.Forms.TabDrawMode.OwnerDrawFixed
        Me.MhTab1.ItemSize = New System.Drawing.Size(202, 18)
        Me.MhTab1.Location = New System.Drawing.Point(12, 14)
        Me.MhTab1.Multiline = True
        Me.MhTab1.Name = "MhTab1"
        Me.MhTab1.SelectedIndex = 0
        Me.MhTab1.Size = New System.Drawing.Size(498, 371)
        Me.MhTab1.TabIndex = 3
        Me.MhTab1.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.MhTab1, "")
        '
        '_MhTab1_TabPage0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhTab1_TabPage0, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhTab1_TabPage0, False)
        Me._MhTab1_TabPage0.Controls.Add(Me._Frame1_0)
        Me.COBISStyleProvider.SetControlStyle(Me._MhTab1_TabPage0, "Default")
        Me._MhTab1_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._MhTab1_TabPage0.Name = "_MhTab1_TabPage0"
        Me.COBISResourceProvider.SetResourceID(Me._MhTab1_TabPage0, "9105")
        Me._MhTab1_TabPage0.Size = New System.Drawing.Size(490, 345)
        Me._MhTab1_TabPage0.TabIndex = 0
        Me._MhTab1_TabPage0.Text = "*Centros de Canje"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhTab1_TabPage0, "")
        '
        '_Frame1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame1_0, False)
        Me._Frame1_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame1_0.Controls.Add(Me.GroupBox1)
        Me._Frame1_0.Controls.Add(Me._Frame4_0)
        Me._Frame1_0.Controls.Add(Me.lblSecuencial)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame1_0, "Default")
        Me._Frame1_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame1_0.Location = New System.Drawing.Point(3, 4)
        Me._Frame1_0.Name = "_Frame1_0"
        Me._Frame1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame1_0.Size = New System.Drawing.Size(485, 341)
        Me._Frame1_0.TabIndex = 32
        Me._Frame1_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame1_0, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.Location = New System.Drawing.Point(8, 116)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "502544")
        Me.GroupBox1.Size = New System.Drawing.Size(468, 222)
        Me.GroupBox1.TabIndex = 42
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "*Centros de Canje Vigentes"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(6, 17)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(456, 199)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 33
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_Frame4_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_0, False)
        Me._Frame4_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_0.Controls.Add(Me.txtDesc)
        Me._Frame4_0.Controls.Add(Me._txtCampo_0)
        Me._Frame4_0.Controls.Add(Me._txtCampo_1)
        Me._Frame4_0.Controls.Add(Me._lblEtiqueta_0)
        Me._Frame4_0.Controls.Add(Me._lblDescripcion_0)
        Me._Frame4_0.Controls.Add(Me._lblEtiqueta_6)
        Me._Frame4_0.Controls.Add(Me._lblDescripcion_1)
        Me._Frame4_0.Controls.Add(Me._lblEtiqueta_12)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_0, "Default")
        Me._Frame4_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame4_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_0.Location = New System.Drawing.Point(8, 12)
        Me._Frame4_0.Name = "_Frame4_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame4_0, "502589")
        Me._Frame4_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_0.Size = New System.Drawing.Size(473, 97)
        Me._Frame4_0.TabIndex = 35
        Me._Frame4_0.Text = "*Información General"
        Me._Frame4_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_0, "")
        '
        'txtDesc
        '
        Me.txtDesc.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDesc, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDesc, False)
        Me.txtDesc.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtDesc, "Default")
        Me.txtDesc.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDesc.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me.txtDesc.Location = New System.Drawing.Point(84, 70)
        Me.txtDesc.MaxLength = 255
        Me.txtDesc.Name = "txtDesc"
        Me.txtDesc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDesc.Size = New System.Drawing.Size(379, 20)
        Me.txtDesc.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDesc, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._txtCampo_0.Location = New System.Drawing.Point(84, 19)
        Me._txtCampo_0.MaxLength = 6
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(52, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._txtCampo_1.Location = New System.Drawing.Point(84, 44)
        Me._txtCampo_1.MaxLength = 5
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(52, 20)
        Me._txtCampo_1.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(8, 70)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500643")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_0.TabIndex = 6
        Me._lblEtiqueta_0.Text = "*Descripción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblDescripcion_0.Location = New System.Drawing.Point(138, 19)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(325, 20)
        Me._lblDescripcion_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(9, 19)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "2420")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_6.TabIndex = 0
        Me._lblEtiqueta_6.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblDescripcion_1.Location = New System.Drawing.Point(138, 44)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(325, 20)
        Me._lblDescripcion_1.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(8, 46)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "501907")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_12.TabIndex = 3
        Me._lblEtiqueta_12.Text = "*Ciudad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        'lblSecuencial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblSecuencial, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblSecuencial, False)
        Me.lblSecuencial.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblSecuencial.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblSecuencial, "Default")
        Me.lblSecuencial.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblSecuencial.Location = New System.Drawing.Point(451, 113)
        Me.lblSecuencial.Name = "lblSecuencial"
        Me.lblSecuencial.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblSecuencial.Size = New System.Drawing.Size(25, 17)
        Me.lblSecuencial.TabIndex = 41
        Me.lblSecuencial.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblSecuencial, "")
        '
        '_MhTab1_TabPage1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhTab1_TabPage1, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhTab1_TabPage1, False)
        Me._MhTab1_TabPage1.Controls.Add(Me.Frame2)
        Me.COBISStyleProvider.SetControlStyle(Me._MhTab1_TabPage1, "Default")
        Me._MhTab1_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._MhTab1_TabPage1.Name = "_MhTab1_TabPage1"
        Me.COBISResourceProvider.SetResourceID(Me._MhTab1_TabPage1, "502602")
        Me._MhTab1_TabPage1.Size = New System.Drawing.Size(490, 345)
        Me._MhTab1_TabPage1.TabIndex = 1
        Me._MhTab1_TabPage1.Text = "*Oficina - Centro de Canje"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhTab1_TabPage1, "")
        '
        'Frame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame2, False)
        Me.Frame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame2.Controls.Add(Me.GroupBox2)
        Me.Frame2.Controls.Add(Me._Frame4_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame2, "Default")
        Me.Frame2.ForeColor = System.Drawing.Color.Navy
        Me.Frame2.Location = New System.Drawing.Point(3, 4)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(485, 341)
        Me.Frame2.TabIndex = 24
        Me.Frame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame2, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColor = System.Drawing.Color.Transparent
        Me.GroupBox2.Controls.Add(Me.grdOfiCanje)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox2.Location = New System.Drawing.Point(8, 116)
        Me.GroupBox2.Name = "GroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox2, "502602")
        Me.GroupBox2.Size = New System.Drawing.Size(473, 218)
        Me.GroupBox2.TabIndex = 51
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "*Oficina - Centro de Canje"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'grdOfiCanje
        '
        Me.grdOfiCanje._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdOfiCanje, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdOfiCanje, False)
        Me.grdOfiCanje.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdOfiCanje.Clip = ""
        Me.grdOfiCanje.Col = CType(1, Short)
        Me.grdOfiCanje.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdOfiCanje.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdOfiCanje.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdOfiCanje, "Default")
        Me.grdOfiCanje.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdOfiCanje, True)
        Me.grdOfiCanje.FixedCols = CType(1, Short)
        Me.grdOfiCanje.FixedRows = CType(1, Short)
        Me.grdOfiCanje.ForeColor = System.Drawing.Color.Black
        Me.grdOfiCanje.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdOfiCanje.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdOfiCanje.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdOfiCanje.HighLight = True
        Me.grdOfiCanje.Location = New System.Drawing.Point(6, 17)
        Me.grdOfiCanje.Name = "grdOfiCanje"
        Me.grdOfiCanje.Picture = Nothing
        Me.grdOfiCanje.Row = CType(1, Short)
        Me.grdOfiCanje.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdOfiCanje.Size = New System.Drawing.Size(457, 196)
        Me.grdOfiCanje.Sort = CType(2, Short)
        Me.grdOfiCanje.TabIndex = 31
        Me.grdOfiCanje.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdOfiCanje, "")
        '
        '_Frame4_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_1, False)
        Me._Frame4_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_1.Controls.Add(Me._txtCampo_4)
        Me._Frame4_1.Controls.Add(Me._txtCampo_3)
        Me._Frame4_1.Controls.Add(Me._txtCampo_2)
        Me._Frame4_1.Controls.Add(Me._lblDescripcion_4)
        Me._Frame4_1.Controls.Add(Me._lblEtiqueta_5)
        Me._Frame4_1.Controls.Add(Me._lblDescripcion_3)
        Me._Frame4_1.Controls.Add(Me._lblEtiqueta_4)
        Me._Frame4_1.Controls.Add(Me._lblDescripcion_2)
        Me._Frame4_1.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_1, "Default")
        Me._Frame4_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame4_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_1.Location = New System.Drawing.Point(8, 13)
        Me._Frame4_1.Name = "_Frame4_1"
        Me.COBISResourceProvider.SetResourceID(Me._Frame4_1, "502589")
        Me._Frame4_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_1.Size = New System.Drawing.Size(473, 97)
        Me._Frame4_1.TabIndex = 42
        Me._Frame4_1.Text = "*Información General"
        Me._Frame4_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_1, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._txtCampo_4.Location = New System.Drawing.Point(84, 70)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(52, 20)
        Me._txtCampo_4.TabIndex = 51
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._txtCampo_3.Location = New System.Drawing.Point(84, 44)
        Me._txtCampo_3.MaxLength = 5
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(52, 20)
        Me._txtCampo_3.TabIndex = 44
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._txtCampo_2.Location = New System.Drawing.Point(84, 19)
        Me._txtCampo_2.MaxLength = 6
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(52, 20)
        Me._txtCampo_2.TabIndex = 43
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblDescripcion_4.Location = New System.Drawing.Point(138, 70)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(325, 20)
        Me._lblDescripcion_4.TabIndex = 52
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(8, 44)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501907")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_5.TabIndex = 49
        Me._lblEtiqueta_5.Text = "*Ciudad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblDescripcion_3.Location = New System.Drawing.Point(138, 44)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(325, 20)
        Me._lblDescripcion_3.TabIndex = 48
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(9, 19)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "2420")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_4.TabIndex = 47
        Me._lblEtiqueta_4.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblDescripcion_2.Location = New System.Drawing.Point(138, 19)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(325, 20)
        Me._lblDescripcion_2.TabIndex = 46
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(8, 70)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "502540")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(70, 20)
        Me._lblEtiqueta_3.TabIndex = 45
        Me._lblEtiqueta_3.Text = "*C. Canje:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_cmdBoton_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_6, False)
        Me._cmdBoton_6.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_6, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_6, True)
        Me._cmdBoton_6.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_6, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_6, Nothing)
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-617, 36)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 25
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Tag = "8005;8006"
        Me._cmdBoton_6.Text = "*&Buscar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        '_cmdBoton_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_10, False)
        Me._cmdBoton_10.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_10, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_10, True)
        Me._cmdBoton_10.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_10, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_10, Nothing)
        Me._cmdBoton_10.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_10.Location = New System.Drawing.Point(-554, 302)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_10, System.Drawing.Color.Silver)
        Me._cmdBoton_10.Name = "_cmdBoton_10"
        Me._cmdBoton_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_10.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_10, 1)
        Me._cmdBoton_10.TabIndex = 29
        Me._cmdBoton_10.TabStop = False
        Me._cmdBoton_10.Text = "*&Limpiar"
        Me._cmdBoton_10.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_10.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_10, "")
        '
        '_cmdBoton_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_9, False)
        Me._cmdBoton_9.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_9, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_9, True)
        Me._cmdBoton_9.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_9, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_9, Nothing)
        Me._cmdBoton_9.Enabled = False
        Me._cmdBoton_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_9.Location = New System.Drawing.Point(-554, 246)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_9, System.Drawing.Color.Silver)
        Me._cmdBoton_9.Name = "_cmdBoton_9"
        Me._cmdBoton_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_9.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_9, 1)
        Me._cmdBoton_9.TabIndex = 28
        Me._cmdBoton_9.TabStop = False
        Me._cmdBoton_9.Tag = "8005;8006"
        Me._cmdBoton_9.Text = "*&Eliminar"
        Me._cmdBoton_9.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_9.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_9, "")
        '
        '_cmdBoton_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_7, False)
        Me._cmdBoton_7.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_7, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_7, True)
        Me._cmdBoton_7.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_7, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_7, Nothing)
        Me._cmdBoton_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_7.Location = New System.Drawing.Point(-554, 139)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 26
        Me._cmdBoton_7.TabStop = False
        Me._cmdBoton_7.Tag = "8001"
        Me._cmdBoton_7.Text = "*&Ingresar"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        '_cmdBoton_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_8, False)
        Me._cmdBoton_8.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_8, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_8, True)
        Me._cmdBoton_8.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_8, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_8, Nothing)
        Me._cmdBoton_8.Enabled = False
        Me._cmdBoton_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_8.Location = New System.Drawing.Point(-554, 192)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_8, System.Drawing.Color.Silver)
        Me._cmdBoton_8.Name = "_cmdBoton_8"
        Me._cmdBoton_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_8.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_8, 1)
        Me._cmdBoton_8.TabIndex = 27
        Me._cmdBoton_8.TabStop = False
        Me._cmdBoton_8.Tag = "8002"
        Me._cmdBoton_8.Text = "*&Modificar"
        Me._cmdBoton_8.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_8.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_8, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-554, 36)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(57, 46)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 53
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_14, False)
        Me._cmdBoton_14.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_14, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_14, True)
        Me._cmdBoton_14.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_14, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_14, Nothing)
        Me._cmdBoton_14.Enabled = False
        Me._cmdBoton_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_14.Location = New System.Drawing.Point(-554, 91)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_14, System.Drawing.Color.Silver)
        Me._cmdBoton_14.Name = "_cmdBoton_14"
        Me._cmdBoton_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_14.Size = New System.Drawing.Size(57, 44)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_14, 1)
        Me._cmdBoton_14.TabIndex = 54
        Me._cmdBoton_14.TabStop = False
        Me._cmdBoton_14.Text = "*Siguien&te"
        Me._cmdBoton_14.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_14.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_14, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-617, 139)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(57, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 55
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Ingresar"
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
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.Enabled = False
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-617, 192)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(56, 48)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 56
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Modificar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-617, 246)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(57, 47)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 57
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Eliminar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-617, 304)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(57, 46)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 58
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Limpiar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-554, 358)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(57, 46)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 59
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*&Salir"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'Frame3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3, False)
        Me.Frame3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3.Controls.Add(Me._picVisto_5)
        Me.Frame3.Controls.Add(Me._picVisto_4)
        Me.Frame3.Controls.Add(Me._txtCampo_5)
        Me.Frame3.Controls.Add(Me._SSCheck1_0)
        Me.Frame3.Controls.Add(Me.grdPagos)
        Me.Frame3.Controls.Add(Me._cmdBoton_12)
        Me.Frame3.Controls.Add(Me._cmdBoton_16)
        Me.Frame3.Controls.Add(Me._cmdBoton_13)
        Me.Frame3.Controls.Add(Me._cmdBoton_15)
        Me.Frame3.Controls.Add(Me._lblEtiqueta_21)
        Me.Frame3.Controls.Add(Me._lblDescripcion_5)
        Me.Frame3.Controls.Add(Me._lblEtiqueta_2)
        Me.Frame3.Controls.Add(Me._lblEtiqueta_20)
        Me.Frame3.Controls.Add(Me._lblDescripcion_14)
        Me.Frame3.Controls.Add(Me._lblEtiqueta_19)
        Me.Frame3.Controls.Add(Me._lblDescripcion_13)
        Me.Frame3.Controls.Add(Me._lblDescripcion_11)
        Me.Frame3.Controls.Add(Me._lblEtiqueta_18)
        Me.Frame3.Controls.Add(Me._lblDescripcion_12)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3, "Default")
        Me.Frame3.ForeColor = System.Drawing.Color.Navy
        Me.Frame3.Location = New System.Drawing.Point(10, 10)
        Me.Frame3.Name = "Frame3"
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(552, 322)
        Me.Frame3.TabIndex = 4
        Me.Frame3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3, "")
        '
        '_picVisto_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_5, False)
        Me._picVisto_5.BackColor = System.Drawing.Color.Silver
        Me._picVisto_5.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_5, "Default")
        Me._picVisto_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_5.Location = New System.Drawing.Point(22, 84)
        Me._picVisto_5.Name = "_picVisto_5"
        Me._picVisto_5.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_5.TabIndex = 7
        Me._picVisto_5.TabStop = False
        Me._picVisto_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_5, "")
        '
        '_picVisto_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_4, False)
        Me._picVisto_4.BackColor = System.Drawing.Color.Gray
        Me._picVisto_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_4, "Default")
        Me._picVisto_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_4.Location = New System.Drawing.Point(10, 84)
        Me._picVisto_4.Name = "_picVisto_4"
        Me._picVisto_4.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_4.TabIndex = 6
        Me._picVisto_4.TabStop = False
        Me._picVisto_4.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_4, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(145, 60)
        Me._txtCampo_5.MaxLength = 3
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(68, 20)
        Me._txtCampo_5.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_SSCheck1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._SSCheck1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._SSCheck1_0, False)
        Me._SSCheck1_0.BackColor = System.Drawing.Color.Transparent
        Me._SSCheck1_0.Checked = True
        Me._SSCheck1_0.CheckState = System.Windows.Forms.CheckState.Checked
        Me.COBISStyleProvider.SetControlStyle(Me._SSCheck1_0, "Default")
        Me._SSCheck1_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._SSCheck1_0.ForeColor = System.Drawing.Color.White
        Me._SSCheck1_0.Location = New System.Drawing.Point(276, 86)
        Me._SSCheck1_0.Name = "_SSCheck1_0"
        Me._SSCheck1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._SSCheck1_0.Size = New System.Drawing.Size(17, 14)
        Me._SSCheck1_0.TabIndex = 8
        Me._SSCheck1_0.Text = "SSCheck1"
        Me._SSCheck1_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._SSCheck1_0, "")
        '
        'grdPagos
        '
        Me.grdPagos._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdPagos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdPagos, False)
        Me.grdPagos.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPagos.Clip = ""
        Me.grdPagos.Col = CType(1, Short)
        Me.grdPagos.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPagos.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPagos.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdPagos, "Default")
        Me.grdPagos.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPagos, True)
        Me.grdPagos.FixedCols = CType(1, Short)
        Me.grdPagos.FixedRows = CType(1, Short)
        Me.grdPagos.ForeColor = System.Drawing.Color.Black
        Me.grdPagos.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPagos.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPagos.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPagos.HighLight = True
        Me.grdPagos.Location = New System.Drawing.Point(3, 118)
        Me.grdPagos.Name = "grdPagos"
        Me.grdPagos.Picture = Nothing
        Me.grdPagos.Row = CType(1, Short)
        Me.grdPagos.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPagos.Size = New System.Drawing.Size(484, 201)
        Me.grdPagos.Sort = CType(2, Short)
        Me.grdPagos.TabIndex = 9
        Me.grdPagos.TabStop = False
        Me.grdPagos.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPagos, "")
        '
        '_cmdBoton_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_12, False)
        Me._cmdBoton_12.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_12, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_12, True)
        Me._cmdBoton_12.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_12, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_12, Nothing)
        Me._cmdBoton_12.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_12.Location = New System.Drawing.Point(10, 10)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_12, System.Drawing.Color.Silver)
        Me._cmdBoton_12.Name = "_cmdBoton_12"
        Me._cmdBoton_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_12.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_12, 1)
        Me._cmdBoton_12.TabIndex = 10
        Me._cmdBoton_12.TabStop = False
        Me._cmdBoton_12.Tag = "8005;8006"
        Me._cmdBoton_12.Text = "&Buscar89"
        Me._cmdBoton_12.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_12.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_12, "")
        '
        '_cmdBoton_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_16, False)
        Me._cmdBoton_16.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_16, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_16, True)
        Me._cmdBoton_16.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_16, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_16, Nothing)
        Me._cmdBoton_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_16.Location = New System.Drawing.Point(600, 214)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_16, System.Drawing.Color.Silver)
        Me._cmdBoton_16.Name = "_cmdBoton_16"
        Me._cmdBoton_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_16.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_16, 1)
        Me._cmdBoton_16.TabIndex = 11
        Me._cmdBoton_16.TabStop = False
        Me._cmdBoton_16.Text = "&Limpiar"
        Me._cmdBoton_16.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_16.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_16, "")
        '
        '_cmdBoton_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_13, False)
        Me._cmdBoton_13.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_13, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_13, True)
        Me._cmdBoton_13.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_13, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_13, Nothing)
        Me._cmdBoton_13.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_13.Location = New System.Drawing.Point(500, 62)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_13, System.Drawing.Color.Silver)
        Me._cmdBoton_13.Name = "_cmdBoton_13"
        Me._cmdBoton_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_13.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_13, 1)
        Me._cmdBoton_13.TabIndex = 12
        Me._cmdBoton_13.TabStop = False
        Me._cmdBoton_13.Tag = "8001"
        Me._cmdBoton_13.Text = "&Ingresar"
        Me._cmdBoton_13.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_13.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_13, "")
        '
        '_cmdBoton_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_15, False)
        Me._cmdBoton_15.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_15, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_15, True)
        Me._cmdBoton_15.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_15, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_15, Nothing)
        Me._cmdBoton_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_15.Location = New System.Drawing.Point(600, 162)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_15, System.Drawing.Color.Silver)
        Me._cmdBoton_15.Name = "_cmdBoton_15"
        Me._cmdBoton_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_15.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_15, 1)
        Me._cmdBoton_15.TabIndex = 13
        Me._cmdBoton_15.TabStop = False
        Me._cmdBoton_15.Tag = "8005;8006"
        Me._cmdBoton_15.Text = "&Eliminar"
        Me._cmdBoton_15.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_15.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_15, "")
        '
        '_lblEtiqueta_21
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_21, False)
        Me._lblEtiqueta_21.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_21, "Default")
        Me._lblEtiqueta_21.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_21.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_21.Location = New System.Drawing.Point(296, 86)
        Me._lblEtiqueta_21.Name = "_lblEtiqueta_21"
        Me._lblEtiqueta_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_21.Size = New System.Drawing.Size(181, 20)
        Me._lblEtiqueta_21.TabIndex = 23
        Me._lblEtiqueta_21.Text = "Se permite en horario extendido"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_21, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(215, 59)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(270, 19)
        Me._lblDescripcion_5.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(43, 64)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(90, 20)
        Me._lblEtiqueta_2.TabIndex = 21
        Me._lblEtiqueta_2.Text = "Forma de Pago:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_20, False)
        Me._lblEtiqueta_20.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_20, "Default")
        Me._lblEtiqueta_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_20.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_20.Location = New System.Drawing.Point(3, 103)
        Me._lblEtiqueta_20.Name = "_lblEtiqueta_20"
        Me._lblEtiqueta_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_20.Size = New System.Drawing.Size(96, 20)
        Me._lblEtiqueta_20.TabIndex = 20
        Me._lblEtiqueta_20.Text = "Formas de Pago:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_20, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(215, 39)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(270, 19)
        Me._lblDescripcion_14.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblEtiqueta_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_19, False)
        Me._lblEtiqueta_19.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_19, "Default")
        Me._lblEtiqueta_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_19.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_19.Location = New System.Drawing.Point(29, 42)
        Me._lblEtiqueta_19.Name = "_lblEtiqueta_19"
        Me._lblEtiqueta_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_19.Size = New System.Drawing.Size(103, 20)
        Me._lblEtiqueta_19.TabIndex = 18
        Me._lblEtiqueta_19.Text = "Tipo de Impuesto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_19, "")
        '
        '_lblDescripcion_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_13, False)
        Me._lblDescripcion_13.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_13.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_13, "Default")
        Me._lblDescripcion_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_13.Location = New System.Drawing.Point(146, 39)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(67, 19)
        Me._lblDescripcion_13.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(146, 18)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(67, 19)
        Me._lblDescripcion_11.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblEtiqueta_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_18, False)
        Me._lblEtiqueta_18.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_18, "Default")
        Me._lblEtiqueta_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_18.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_18.Location = New System.Drawing.Point(25, 21)
        Me._lblEtiqueta_18.Name = "_lblEtiqueta_18"
        Me._lblEtiqueta_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_18.Size = New System.Drawing.Size(109, 20)
        Me._lblEtiqueta_18.TabIndex = 15
        Me._lblEtiqueta_18.Text = "Clase de Impuesto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_18, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(215, 18)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(269, 19)
        Me._lblDescripcion_12.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.MhTab1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(519, 393)
        Me.PFormas.TabIndex = 25
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBBuscar2, Me.TSBSiguientes, Me.TSBIngresar, Me.TSBIngresar2, Me.TSBModificar, Me.TSBModificar2, Me.TSBEliminar, Me.TSBEliminar2, Me.TSBLimpiar, Me.TSBLimpiar2, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(539, 25)
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
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBBuscar2
        '
        Me.TSBBuscar2.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar2.Image = CType(resources.GetObject("TSBBuscar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar2, "2000")
        Me.TSBBuscar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar2.Name = "TSBBuscar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar2, "2000")
        Me.TSBBuscar2.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar2.Text = "*&Buscar"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.Size = New System.Drawing.Size(66, 22)
        Me.TSBSiguientes.Text = "*Si&gtes."
        '
        'TSBIngresar
        '
        Me.TSBIngresar.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar.Image = CType(resources.GetObject("TSBIngresar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar.Name = "TSBIngresar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar, "2030")
        Me.TSBIngresar.Size = New System.Drawing.Size(60, 22)
        Me.TSBIngresar.Text = "*&Crear"
        '
        'TSBIngresar2
        '
        Me.TSBIngresar2.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar2.Image = CType(resources.GetObject("TSBIngresar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar2, "2004")
        Me.TSBIngresar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar2.Name = "TSBIngresar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar2, "2030")
        Me.TSBIngresar2.Size = New System.Drawing.Size(60, 22)
        Me.TSBIngresar2.Text = "*&Crear"
        '
        'TSBModificar
        '
        Me.TSBModificar.ForeColor = System.Drawing.Color.Black
        Me.TSBModificar.Image = CType(resources.GetObject("TSBModificar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBModificar, "2005")
        Me.TSBModificar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBModificar.Name = "TSBModificar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBModificar, "2031")
        Me.TSBModificar.Size = New System.Drawing.Size(80, 22)
        Me.TSBModificar.Text = "*&Actualizar"
        '
        'TSBModificar2
        '
        Me.TSBModificar2.ForeColor = System.Drawing.Color.Black
        Me.TSBModificar2.Image = CType(resources.GetObject("TSBModificar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBModificar2, "2005")
        Me.TSBModificar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBModificar2.Name = "TSBModificar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBModificar2, "2031")
        Me.TSBModificar2.Size = New System.Drawing.Size(80, 22)
        Me.TSBModificar2.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(69, 20)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBEliminar2
        '
        Me.TSBEliminar2.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar2.Image = CType(resources.GetObject("TSBEliminar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar2, "2006")
        Me.TSBEliminar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar2.Name = "TSBEliminar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar2, "2050")
        Me.TSBEliminar2.Size = New System.Drawing.Size(69, 20)
        Me.TSBEliminar2.Text = "*&Eliminar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(66, 20)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBLimpiar2
        '
        Me.TSBLimpiar2.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar2.Image = CType(resources.GetObject("TSBLimpiar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar2, "2003")
        Me.TSBLimpiar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar2.Name = "TSBLimpiar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar2, "2003")
        Me.TSBLimpiar2.Size = New System.Drawing.Size(66, 20)
        Me.TSBLimpiar2.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 20)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran2810Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me._cmdBoton_6)
        Me.Controls.Add(Me._cmdBoton_10)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_9)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_7)
        Me.Controls.Add(Me._cmdBoton_14)
        Me.Controls.Add(Me._cmdBoton_8)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(3, 29)
        Me.Name = "FTran2810Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(539, 442)
        Me.Text = "Mantenimiento Centros de Canje"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.MhTab1.ResumeLayout(False)
        Me._MhTab1_TabPage0.ResumeLayout(False)
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame1_0.ResumeLayout(False)
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_0.ResumeLayout(False)
        Me._Frame4_0.PerformLayout()
        Me._MhTab1_TabPage1.ResumeLayout(False)
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame2.ResumeLayout(False)
        Me.GroupBox2.ResumeLayout(False)
        CType(Me.grdOfiCanje, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_1.ResumeLayout(False)
        Me._Frame4_1.PerformLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3.ResumeLayout(False)
        Me.Frame3.PerformLayout()
        CType(Me._picVisto_5, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_4, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdPagos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(5) = _txtCampo_5
    End Sub
    Sub InitializepicVisto()
        Me.picVisto(5) = _picVisto_5
        Me.picVisto(4) = _picVisto_4
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        'Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        'Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(21) = _lblEtiqueta_21
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(20) = _lblEtiqueta_20
        Me.lblEtiqueta(19) = _lblEtiqueta_19
        Me.lblEtiqueta(18) = _lblEtiqueta_18
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(13) = _lblDescripcion_13
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(12) = _lblDescripcion_12
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(14) = _cmdBoton_14
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(10) = _cmdBoton_10
        Me.cmdBoton(9) = _cmdBoton_9
        ' Me.cmdBoton(11) = _cmdBoton_11
        Me.cmdBoton(7) = _cmdBoton_7
        Me.cmdBoton(8) = _cmdBoton_8
        Me.cmdBoton(12) = _cmdBoton_12
        Me.cmdBoton(16) = _cmdBoton_16
        Me.cmdBoton(13) = _cmdBoton_13
        Me.cmdBoton(15) = _cmdBoton_15
    End Sub
    Sub InitializeSSCheck1()
        Me.SSCheck1(0) = _SSCheck1_0
    End Sub
    Sub InitializeFrame4()
        Me.Frame4(0) = _Frame4_0
        Me.Frame4(1) = _Frame4_1
    End Sub
    Sub InitializeFrame1()
        Me.Frame1(0) = _Frame1_0
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBIngresar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBModificar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents TSBBuscar2 As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBIngresar2 As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBModificar2 As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar2 As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar2 As System.Windows.Forms.ToolStripButton
#End Region
End Class


