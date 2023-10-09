Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FTran436Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializeoptTipoR()
        InitializemskValor()
        InitializelblOficina()
        InitializelblEtiqueta()
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
    Public WithEvents cmbprodb As System.Windows.Forms.ComboBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents txtOficina As System.Windows.Forms.TextBox
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _optTipoR_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optTipoR_0 As System.Windows.Forms.RadioButton
    Public WithEvents FrameTipoR As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblOficina_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public cmdBoton(3) As System.Windows.Forms.Button
    Public lblEtiqueta(5) As System.Windows.Forms.Label
    Public lblOficina(1) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public optTipoR(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran436Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmbprodb = New System.Windows.Forms.ComboBox()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me.txtOficina = New System.Windows.Forms.TextBox()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.FrameTipoR = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optTipoR_1 = New System.Windows.Forms.RadioButton()
        Me._optTipoR_0 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblOficina_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.FrameTipoR, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrameTipoR.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'cmbprodb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbprodb, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbprodb, False)
        Me.cmbprodb.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbprodb, "Default")
        Me.cmbprodb.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbprodb.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbprodb.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbprodb.Location = New System.Drawing.Point(97, 33)
        Me.cmbprodb.Name = "cmbprodb"
        Me.cmbprodb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbprodb.Size = New System.Drawing.Size(175, 21)
        Me.cmbprodb.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbprodb, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(657, 168)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 14
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "6335"
        Me._cmdBoton_1.Text = "*&Imprimir"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        'txtOficina
        '
        Me.txtOficina.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtOficina, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtOficina, False)
        Me.txtOficina.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtOficina, "Default")
        Me.txtOficina.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtOficina.Location = New System.Drawing.Point(97, 10)
        Me.txtOficina.MaxLength = 4
        Me.txtOficina.Name = "txtOficina"
        Me.txtOficina.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtOficina.Size = New System.Drawing.Size(51, 20)
        Me.txtOficina.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtOficina, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me._mskValor_1.Enabled = False
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(97, 79)
        Me._mskValor_1.Mask = "##/##/####"
        Me._mskValor_1.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(175, 20)
        Me._mskValor_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me._mskValor_0.Enabled = False
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(97, 56)
        Me._mskValor_0.Mask = "##/##/####"
        Me._mskValor_0.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(175, 20)
        Me._mskValor_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        'FrameTipoR
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrameTipoR, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrameTipoR, False)
        Me.FrameTipoR.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrameTipoR.Controls.Add(Me._optTipoR_1)
        Me.FrameTipoR.Controls.Add(Me._optTipoR_0)
        Me.COBISStyleProvider.SetControlStyle(Me.FrameTipoR, "Default")
        Me.FrameTipoR.ForeColor = System.Drawing.Color.Navy
        Me.FrameTipoR.Location = New System.Drawing.Point(298, 37)
        Me.FrameTipoR.Name = "FrameTipoR"
        Me.COBISResourceProvider.SetResourceID(Me.FrameTipoR, "501550")
        Me.FrameTipoR.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrameTipoR.Size = New System.Drawing.Size(254, 59)
        Me.FrameTipoR.TabIndex = 4
        Me.FrameTipoR.Text = "*Tipo de Consulta"
        Me.FrameTipoR.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrameTipoR, "")
        '
        '_optTipoR_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoR_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoR_1, False)
        Me._optTipoR_1.AutoSize = True
        Me._optTipoR_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoR_1, "Default")
        Me._optTipoR_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoR_1.ForeColor = System.Drawing.Color.Navy
        Me._optTipoR_1.Location = New System.Drawing.Point(108, 22)
        Me._optTipoR_1.Name = "_optTipoR_1"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoR_1, "508465")
        Me._optTipoR_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoR_1.Size = New System.Drawing.Size(146, 17)
        Me._optTipoR_1.TabIndex = 11
        Me._optTipoR_1.Text = "*Con Incumplimientos"
        Me._optTipoR_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoR_1, "")
        '
        '_optTipoR_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoR_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoR_0, False)
        Me._optTipoR_0.AutoSize = True
        Me._optTipoR_0.BackColor = System.Drawing.Color.Transparent
        Me._optTipoR_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoR_0, "Default")
        Me._optTipoR_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoR_0.ForeColor = System.Drawing.Color.Navy
        Me._optTipoR_0.Location = New System.Drawing.Point(12, 22)
        Me._optTipoR_0.Name = "_optTipoR_0"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoR_0, "508687")
        Me._optTipoR_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoR_0.Size = New System.Drawing.Size(93, 17)
        Me._optTipoR_0.TabIndex = 10
        Me._optTipoR_0.TabStop = True
        Me._optTipoR_0.Text = "*Por Vencer"
        Me._optTipoR_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoR_0, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(657, 270)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 16
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me.grdRegistros.Location = New System.Drawing.Point(5, 18)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(540, 209)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 13
        Me.grdRegistros.TabStop = False
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(657, 10)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 12
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(657, 219)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 15
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Limpiar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(673, 73)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "5048")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(67, 13)
        Me._lblEtiqueta_2.TabIndex = 4
        Me._lblEtiqueta_2.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "2420")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(56, 13)
        Me._lblEtiqueta_1.TabIndex = 1
        Me._lblEtiqueta_1.Text = "*Oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblOficina_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblOficina_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblOficina_1, False)
        Me._lblOficina_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblOficina_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblOficina_1, "Default")
        Me._lblOficina_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblOficina_1.Location = New System.Drawing.Point(150, 10)
        Me._lblOficina_1.Name = "_lblOficina_1"
        Me._lblOficina_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblOficina_1.Size = New System.Drawing.Size(402, 19)
        Me._lblOficina_1.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblOficina_1, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.AutoSize = True
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "501499")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(86, 13)
        Me._lblEtiqueta_4.TabIndex = 8
        Me._lblEtiqueta_4.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.AutoSize = True
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "508568")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(89, 13)
        Me._lblEtiqueta_3.TabIndex = 6
        Me._lblEtiqueta_3.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(7, 102)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "508473")
        Me.GroupBox1.Size = New System.Drawing.Size(552, 233)
        Me.GroupBox1.TabIndex = 18
        Me.GroupBox1.Text = "*Consulta Registros :"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.cmbprodb)
        Me.PFormas.Controls.Add(Me.txtOficina)
        Me.PFormas.Controls.Add(Me._mskValor_1)
        Me.PFormas.Controls.Add(Me._mskValor_0)
        Me.PFormas.Controls.Add(Me.FrameTipoR)
        Me.PFormas.Controls.Add(Me.rptReporte)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._lblOficina_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(563, 340)
        Me.PFormas.TabIndex = 19
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBImprimir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(584, 25)
        Me.TSBotones.TabIndex = 20
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
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
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran436Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(14, 120)
        Me.Name = "FTran436Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(584, 386)
        Me.Tag = "3893"
        Me.Text = "Seguimiento Plan de Ahorro Progresivo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.FrameTipoR, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrameTipoR.ResumeLayout(False)
        Me.FrameTipoR.PerformLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptTipoR()
        Me.optTipoR(1) = _optTipoR_1
        Me.optTipoR(0) = _optTipoR_0
    End Sub
    Sub InitializemskValor()
        Me.mskValor(1) = _mskValor_1
        Me.mskValor(0) = _mskValor_0
    End Sub
    Sub InitializelblOficina()
        Me.lblOficina(1) = _lblOficina_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


