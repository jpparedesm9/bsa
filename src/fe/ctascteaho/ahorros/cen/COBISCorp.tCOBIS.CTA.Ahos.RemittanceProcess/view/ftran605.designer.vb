Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran605Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
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
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Public WithEvents SSFrame1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdficticio As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents txtOficina As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdCheque As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
	Public cmdBoton(3) As System.Windows.Forms.Button
	Public lblDescripcion(3) As System.Windows.Forms.Label
	Public lblEtiqueta(6) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran605Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.SSFrame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me.grdficticio = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.txtOficina = New System.Windows.Forms.TextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdCheque = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SSFrame1.SuspendLayout()
        CType(Me.grdficticio, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdCheque, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        'SSFrame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.SSFrame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.SSFrame1, False)
        Me.SSFrame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_1)
        Me.SSFrame1.Controls.Add(Me._lblEtiqueta_3)
        Me.SSFrame1.Controls.Add(Me._lblDescripcion_2)
        Me.SSFrame1.Controls.Add(Me._lblDescripcion_3)
        Me.COBISStyleProvider.SetControlStyle(Me.SSFrame1, "Default")
        Me.SSFrame1.ForeColor = System.Drawing.Color.Navy
        Me.SSFrame1.Location = New System.Drawing.Point(10, 297)
        Me.SSFrame1.Name = "SSFrame1"
        Me.COBISResourceProvider.SetResourceID(Me.SSFrame1, "508720")
        Me.SSFrame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SSFrame1.Size = New System.Drawing.Size(568, 50)
        Me.SSFrame1.TabIndex = 11
        Me.SSFrame1.Text = "*TOTALES"
        Me.SSFrame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.SSFrame1, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(269, 20)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500030")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(48, 20)
        Me._lblEtiqueta_1.TabIndex = 15
        Me._lblEtiqueta_1.Text = "*Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(38, 20)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5228")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(73, 20)
        Me._lblEtiqueta_3.TabIndex = 14
        Me._lblEtiqueta_3.Text = "*Cantidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(105, 18)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(101, 19)
        Me._lblDescripcion_2.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(323, 18)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(226, 19)
        Me._lblDescripcion_3.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        'grdficticio
        '
        Me.grdficticio._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdficticio, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdficticio, False)
        Me.grdficticio.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdficticio.Clip = ""
        Me.grdficticio.Col = CType(1, Short)
        Me.grdficticio.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdficticio.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdficticio.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdficticio, "Default")
        Me.grdficticio.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdficticio, True)
        Me.grdficticio.FixedCols = CType(1, Short)
        Me.grdficticio.FixedRows = CType(1, Short)
        Me.grdficticio.ForeColor = System.Drawing.Color.Black
        Me.grdficticio.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdficticio.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdficticio.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdficticio.HighLight = True
        Me.grdficticio.Location = New System.Drawing.Point(489, 175)
        Me.grdficticio.Name = "grdficticio"
        Me.grdficticio.Picture = Nothing
        Me.grdficticio.Row = CType(1, Short)
        Me.grdficticio.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdficticio.Size = New System.Drawing.Size(48, 33)
        Me.grdficticio.Sort = CType(2, Short)
        Me.grdficticio.TabIndex = 10
        Me.grdficticio.TopRow = CType(1, Short)
        Me.grdficticio.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdficticio, "")
        Me.COBISViewResizer.SetxIncrement(Me.grdficticio, False)
        Me.COBISViewResizer.SetyIncrement(Me.grdficticio, False)
        '
        'txtOficina
        '
        Me.txtOficina.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtOficina, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtOficina, False)
        Me.txtOficina.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtOficina, "Default")
        Me.txtOficina.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOficina.Enabled = False
        Me.txtOficina.Location = New System.Drawing.Point(64, 10)
        Me.txtOficina.MaxLength = 14
        Me.txtOficina.Name = "txtOficina"
        Me.txtOficina.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOficina.Size = New System.Drawing.Size(43, 20)
        Me.txtOficina.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtOficina, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(613, 239)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 9
        Me._cmdBoton_2.Tag = "6335"
        Me._cmdBoton_2.Text = "*&Imprimir"
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
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(613, 60)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 8
        Me._cmdBoton_0.Text = "*Siguien&tes"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(614, 290)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 0
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdCheque
        '
        Me.grdCheque._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCheque, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCheque, False)
        Me.grdCheque.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdCheque.Clip = ""
        Me.grdCheque.Col = CType(1, Short)
        Me.grdCheque.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdCheque.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdCheque.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdCheque, "Default")
        Me.grdCheque.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdCheque, True)
        Me.grdCheque.FixedCols = CType(1, Short)
        Me.grdCheque.FixedRows = CType(1, Short)
        Me.grdCheque.ForeColor = System.Drawing.Color.Black
        Me.grdCheque.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdCheque.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdCheque.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdCheque.HighLight = True
        Me.grdCheque.Location = New System.Drawing.Point(6, 16)
        Me.grdCheque.Name = "grdCheque"
        Me.grdCheque.Picture = Nothing
        Me.grdCheque.Row = CType(1, Short)
        Me.grdCheque.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdCheque.Size = New System.Drawing.Size(554, 240)
        Me.grdCheque.Sort = CType(2, Short)
        Me.grdCheque.TabIndex = 1
        Me.grdCheque.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCheque, "")
        '
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(470, 50)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
        Me.COBISViewResizer.SetxIncrement(Me.rptReporte, False)
        Me.COBISViewResizer.SetyIncrement(Me.rptReporte, False)
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(454, 10)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(124, 19)
        Me._lblDescripcion_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(407, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500348")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(51, 13)
        Me._lblEtiqueta_0.TabIndex = 5
        Me._lblEtiqueta_0.Text = "*Fecha:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "2420")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(56, 13)
        Me._lblEtiqueta_6.TabIndex = 7
        Me._lblEtiqueta_6.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(108, 10)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(290, 19)
        Me._lblDescripcion_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdCheque)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 33)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "508740")
        Me.GroupBox1.Size = New System.Drawing.Size(568, 263)
        Me.GroupBox1.TabIndex = 13
        Me.GroupBox1.Text = "*Total de Cheques:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguientes, Me.TSBImprimir, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(609, 25)
        Me.TSBotones.TabIndex = 14
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Navy
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*Siguien&tes"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Navy
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.SSFrame1)
        Me.PFormas.Controls.Add(Me.grdficticio)
        Me.PFormas.Controls.Add(Me.txtOficina)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me.rptReporte)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(588, 355)
        Me.PFormas.TabIndex = 15
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'FTran605Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(60, 98)
        Me.Name = "FTran605Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(609, 393)
        Me.Tag = "3891"
        Me.Text = "*Total de Cheques vía Bancos por Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SSFrame1.ResumeLayout(False)
        CType(Me.grdficticio, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdCheque, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        ' Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


