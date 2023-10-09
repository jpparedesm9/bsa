'Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FTran351Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        'InitializeLine1()
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
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents lblmalaref As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(5) As System.Windows.Forms.Button
    Public lblDescripcion(9) As System.Windows.Forms.Label
    Public lblEtiqueta(11) As System.Windows.Forms.Label
    Public txtCampo(5) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim Appearance1 As Infragistics.Win.Appearance = New Infragistics.Win.Appearance()
        Dim Appearance2 As Infragistics.Win.Appearance = New Infragistics.Win.Appearance()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran351Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.lblmalaref = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBAnadir = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
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
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(133, 33)
        Me._txtCampo_3.MaxLength = 3
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_3.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(276, 13)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
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
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(616, 175)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 21
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Tag = "6335"
        Me._cmdBoton_5.Text = "*&Imprimir"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me._cmdBoton_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(616, 112)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 36)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 13
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*Eliminar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(133, 56)
        Me._txtCampo_5.MaxLength = 8
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_5.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(133, 79)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_4.TabIndex = 7
        Me._txtCampo_4.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(133, 10)
        Me._txtCampo_2.MaxLength = 2
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_2.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        'grdPropietarios
        '
        Me.grdPropietarios._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdPropietarios, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdPropietarios, False)
        Me.grdPropietarios.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPropietarios.Clip = ""
        Me.grdPropietarios.Col = CType(1, Short)
        Me.grdPropietarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdPropietarios.Cols = 7
        Me.COBISStyleProvider.SetControlStyle(Me.grdPropietarios, "Default")
        Me.grdPropietarios.CtlText = ""
        Me.grdPropietarios.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(3, 16)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(574, 135)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 0
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(616, 75)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 36)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 12
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*Añadir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(10, 60)
        Me._txtCampo_0.MaxLength = 8
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_0.TabIndex = 0
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
        Me._txtCampo_1.Location = New System.Drawing.Point(462, 60)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(25, 20)
        Me._txtCampo_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(616, 226)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 8
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Transmitir"
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(616, 277)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 19
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Limpiar"
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(616, 328)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 20
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'lblmalaref
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblmalaref, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblmalaref, False)
        Me.lblmalaref.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblmalaref.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblmalaref, "Default")
        Me.lblmalaref.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblmalaref.Location = New System.Drawing.Point(19, 102)
        Me.lblmalaref.Name = "lblmalaref"
        Me.lblmalaref.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblmalaref.Size = New System.Drawing.Size(549, 19)
        Me.lblmalaref.TabIndex = 32
        Me.lblmalaref.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.lblmalaref.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblmalaref, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(199, 33)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(369, 20)
        Me._lblDescripcion_7.TabIndex = 31
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500786")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(114, 20)
        Me._lblEtiqueta_2.TabIndex = 30
        Me._lblEtiqueta_2.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(199, 56)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(149, 19)
        Me._lblDescripcion_9.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(199, 79)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(369, 19)
        Me._lblDescripcion_8.TabIndex = 22
        Me._lblDescripcion_8.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(199, 10)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(369, 20)
        Me._lblDescripcion_6.TabIndex = 29
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "5067")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(113, 20)
        Me._lblEtiqueta_4.TabIndex = 20
        Me._lblEtiqueta_4.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5036")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(113, 20)
        Me._lblEtiqueta_3.TabIndex = 21
        Me._lblEtiqueta_3.Text = "*Departamento:"
        Me._lblEtiqueta_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5176")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(120, 20)
        Me._lblEtiqueta_1.TabIndex = 23
        Me._lblEtiqueta_1.Text = "*Producto bancario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(459, 37)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "501129")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(38, 15)
        Me._lblEtiqueta_9.TabIndex = 25
        Me._lblEtiqueta_9.Text = "*Rol:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 37)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "500163")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(57, 15)
        Me._lblEtiqueta_8.TabIndex = 27
        Me._lblEtiqueta_8.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(488, 10)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(83, 19)
        Me._lblDescripcion_1.TabIndex = 14
        Me._lblDescripcion_1.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(340, 10)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "501081")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(151, 19)
        Me._lblEtiqueta_10.TabIndex = 28
        Me._lblEtiqueta_10.Text = "*Fecha de la solicitud:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(188, 60)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(20, 19)
        Me._lblDescripcion_3.TabIndex = 26
        Me._lblDescripcion_3.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(488, 60)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(79, 19)
        Me._lblDescripcion_5.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(211, 60)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(250, 19)
        Me._lblDescripcion_4.TabIndex = 17
        Me._lblDescripcion_4.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(77, 60)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(108, 19)
        Me._lblDescripcion_2.TabIndex = 16
        Me._lblDescripcion_2.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(144, 10)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(65, 19)
        Me._lblDescripcion_0.TabIndex = 15
        Me._lblDescripcion_0.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501080")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(128, 18)
        Me._lblEtiqueta_0.TabIndex = 13
        Me._lblEtiqueta_0.Text = "*Número de solicitud:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(600, 407)
        Me.PFormas.TabIndex = 36
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Appearance1.BackColor = System.Drawing.Color.Transparent
        Appearance1.BackColor2 = System.Drawing.Color.Transparent
        Appearance1.BackColorDisabled = System.Drawing.Color.Transparent
        Appearance1.BackColorDisabled2 = System.Drawing.Color.Transparent
        Me.UltraGroupBox2.Appearance = Appearance1
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_1)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_5)
        Me.UltraGroupBox2.Controls.Add(Me.Label3)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.Size = New System.Drawing.Size(580, 90)
        Me.UltraGroupBox2.TabIndex = 0
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.Label3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Location = New System.Drawing.Point(77, 37)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(384, 19)
        Me.Label3.TabIndex = 30
        Me.Label3.UseMnemonic = False
        Me.Label3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'UltraGroupBox1
        '
        Appearance2.BackColor = System.Drawing.Color.Transparent
        Appearance2.BackColor2 = System.Drawing.Color.Transparent
        Appearance2.BackColorDisabled = System.Drawing.Color.Transparent
        Appearance2.BackColorDisabled2 = System.Drawing.Color.Transparent
        Me.UltraGroupBox1.Appearance = Appearance2
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_3)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_5)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox1.Controls.Add(Me.lblmalaref)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_4)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_2)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 272)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(580, 129)
        Me.UltraGroupBox1.TabIndex = 2
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 110)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "501079")
        Me.GroupBox1.Size = New System.Drawing.Size(580, 154)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.Text = "*Lista de Propietarios"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBAnadir, Me.TSBEliminar, Me.TSBImprimir, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(620, 25)
        Me.TSBBotones.TabIndex = 37
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBAnadir
        '
        Me.TSBAnadir.ForeColor = System.Drawing.Color.Black
        Me.TSBAnadir.Image = CType(resources.GetObject("TSBAnadir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAnadir, "2024")
        Me.TSBAnadir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAnadir.Name = "TSBAnadir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAnadir, "501128")
        Me.TSBAnadir.Size = New System.Drawing.Size(67, 22)
        Me.TSBAnadir.Text = "*&Añadir"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2023")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Black
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2016")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
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
        'FTran351Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(175, 140)
        Me.Name = "FTran351Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(620, 455)
        Me.Tag = "3091"
        Me.Text = "*Solicitud de Apertura de Cuenta de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        Me.UltraGroupBox2.PerformLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(1) = _txtCampo_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        ' Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    'Sub InitializeLine1()
    ' Me.Line1(2) = _Line1_2
    'Me.Line1(1) = _Line1_1
    'Me.Line1(0) = _Line1_0
    'End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBAnadir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents Label3 As System.Windows.Forms.Label
#End Region
End Class


