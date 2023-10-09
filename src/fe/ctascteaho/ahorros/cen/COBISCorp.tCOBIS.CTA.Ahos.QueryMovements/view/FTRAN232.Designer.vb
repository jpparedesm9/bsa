Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FTran232Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializeoptTarjetaDebito()
        InitializemskValor()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
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
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdEstado As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Public WithEvents LblTarjetaDeb As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(7) As System.Windows.Forms.Button
    Public lblDescripcion(12) As System.Windows.Forms.Label
    Public lblEtiqueta(15) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public optTarjetaDebito(1) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran232Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdEstado = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me.LblTarjetaDeb = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.FrmTarjetaDeb = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optTarjetaDebito_0 = New System.Windows.Forms.RadioButton()
        Me._optTarjetaDebito_1 = New System.Windows.Forms.RadioButton()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_13 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBFirma = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        CType(Me.grdEstado, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmTarjetaDeb.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me._lblEtiqueta_13, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._lblEtiqueta_13.SuspendLayout()
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
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(541, 13)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 40
        Me.rptReporte.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
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
        Me._cmdBoton_4.Enabled = False
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 141)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 34
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Firma"
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
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 192)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 4
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*Siguien&tes"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdEstado
        '
        Me.grdEstado._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdEstado, False)
        Me.grdEstado.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdEstado.Clip = ""
        Me.grdEstado.Col = CType(1, Short)
        Me.grdEstado.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdEstado.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdEstado.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdEstado, "Default")
        Me.grdEstado.CtlText = ""
        Me.grdEstado.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdEstado, True)
        Me.grdEstado.FixedCols = CType(1, Short)
        Me.grdEstado.FixedRows = CType(1, Short)
        Me.grdEstado.ForeColor = System.Drawing.Color.Black
        Me.grdEstado.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdEstado.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdEstado.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdEstado.HighLight = True
        Me.grdEstado.Location = New System.Drawing.Point(3, 16)
        Me.grdEstado.Name = "grdEstado"
        Me.grdEstado.Picture = Nothing
        Me.grdEstado.Row = CType(1, Short)
        Me.grdEstado.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdEstado.Size = New System.Drawing.Size(632, 173)
        Me.grdEstado.Sort = CType(2, Short)
        Me.grdEstado.TabIndex = 7
        Me.grdEstado.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdEstado, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(497, 56)
        Me._mskValor_1.Mask = "##/##/####"
        Me._mskValor_1.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(90, 20)
        Me._mskValor_1.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(147, 56)
        Me._mskValor_0.Mask = "##/##/####"
        Me._mskValor_0.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(90, 20)
        Me._mskValor_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(147, 10)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 243)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 3
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 295)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 5
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 346)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 6
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(-700, 90)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 35
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Tag = "6335"
        Me._cmdBoton_5.Text = "*&Imprimir"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'LblTarjetaDeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblTarjetaDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblTarjetaDeb, False)
        Me.LblTarjetaDeb.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.LblTarjetaDeb, "Default")
        Me.LblTarjetaDeb.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblTarjetaDeb.ForeColor = System.Drawing.Color.Navy
        Me.LblTarjetaDeb.Location = New System.Drawing.Point(353, 79)
        Me.LblTarjetaDeb.Name = "LblTarjetaDeb"
        Me.COBISResourceProvider.SetResourceID(Me.LblTarjetaDeb, "2311")
        Me.LblTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblTarjetaDeb.Size = New System.Drawing.Size(97, 20)
        Me.LblTarjetaDeb.TabIndex = 42
        Me.LblTarjetaDeb.Text = "*Tarjeta Débito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblTarjetaDeb, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(10, 125)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2210")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(134, 20)
        Me.Label5.TabIndex = 43
        Me.Label5.Text = "*Alianza:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Location = New System.Drawing.Point(147, 125)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(70, 20)
        Me.Lblalianza.TabIndex = 44
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(220, 125)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(408, 20)
        Me.lbldesalianza.TabIndex = 45
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(413, 9)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_15, "5067")
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(56, 20)
        Me._lblEtiqueta_15.TabIndex = 38
        Me._lblEtiqueta_15.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(483, 9)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(27, 20)
        Me._lblDescripcion_11.TabIndex = 37
        Me._lblDescripcion_11.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(513, 9)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(115, 20)
        Me._lblDescripcion_12.TabIndex = 36
        Me._lblDescripcion_12.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(429, 33)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "500870")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(116, 20)
        Me._lblEtiqueta_14.TabIndex = 33
        Me._lblEtiqueta_14.Text = "*Teléfono:"
        Me._lblEtiqueta_14.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(551, 33)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(77, 20)
        Me._lblDescripcion_10.TabIndex = 32
        Me._lblDescripcion_10.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "500871")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_12.TabIndex = 30
        Me._lblEtiqueta_12.Text = "*Saldo último corte:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(147, 102)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(202, 20)
        Me._lblDescripcion_9.TabIndex = 29
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
        Me._lblDescripcion_8.Location = New System.Drawing.Point(147, 79)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(202, 20)
        Me._lblDescripcion_8.TabIndex = 28
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "501179")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_11.TabIndex = 27
        Me._lblEtiqueta_11.Text = "*Oficial de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(350, 33)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(75, 20)
        Me._lblDescripcion_7.TabIndex = 26
        Me._lblDescripcion_7.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(223, 33)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "501906")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(73, 20)
        Me._lblEtiqueta_10.TabIndex = 25
        Me._lblEtiqueta_10.Text = "*Entidad:"
        Me._lblEtiqueta_10.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(147, 33)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(70, 20)
        Me._lblDescripcion_6.TabIndex = 24
        Me._lblDescripcion_6.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "501907")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(60, 20)
        Me._lblEtiqueta_9.TabIndex = 23
        Me._lblEtiqueta_9.Text = "*Ciudad:"
        Me._lblEtiqueta_9.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(551, 55)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(77, 20)
        Me._lblDescripcion_3.TabIndex = 22
        Me._lblDescripcion_3.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me._lblDescripcion_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(429, 56)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "500875")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(116, 20)
        Me._lblEtiqueta_8.TabIndex = 21
        Me._lblEtiqueta_8.Text = "*Fecha próx. corte:"
        Me._lblEtiqueta_8.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(353, 102)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "5209")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(61, 20)
        Me._lblEtiqueta_7.TabIndex = 8
        Me._lblEtiqueta_7.Text = "*Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(459, 102)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(169, 20)
        Me._lblDescripcion_4.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "500822")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_4.TabIndex = 10
        Me._lblEtiqueta_4.Text = "*Fecha último mov.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(147, 56)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(70, 20)
        Me._lblDescripcion_1.TabIndex = 11
        Me._lblDescripcion_1.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(223, 56)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "500876")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(124, 20)
        Me._lblEtiqueta_2.TabIndex = 12
        Me._lblEtiqueta_2.Text = "*Fecha último corte:"
        Me._lblEtiqueta_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(350, 56)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(75, 20)
        Me._lblDescripcion_2.TabIndex = 13
        Me._lblDescripcion_2.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me._lblDescripcion_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500877")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_1.TabIndex = 14
        Me._lblEtiqueta_1.Text = "*Dir. estado cta.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(147, 10)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(481, 20)
        Me._lblDescripcion_5.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "9492")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_6.TabIndex = 20
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "5172")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_5.TabIndex = 19
        Me._lblEtiqueta_5.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "2400")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_0.TabIndex = 18
        Me._lblEtiqueta_0.Text = "*No. de cuenta:"
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
        Me._lblDescripcion_0.Location = New System.Drawing.Point(147, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(481, 20)
        Me._lblDescripcion_0.TabIndex = 17
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(413, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5173")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(87, 20)
        Me._lblEtiqueta_3.TabIndex = 16
        Me._lblEtiqueta_3.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_13)
        Me.PFormas.Controls.Add(Me.rptReporte)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(658, 453)
        Me.PFormas.TabIndex = 42
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox2.Controls.Add(Me.LblTarjetaDeb)
        Me.UltraGroupBox2.Controls.Add(Me.FrmTarjetaDeb)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_5)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_14)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_11)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox2.Controls.Add(Me.lbldesalianza)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_7)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox2.Controls.Add(Me.Lblalianza)
        Me.UltraGroupBox2.Controls.Add(Me.Label5)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 96)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.Size = New System.Drawing.Size(638, 154)
        Me.UltraGroupBox2.TabIndex = 1
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'FrmTarjetaDeb
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmTarjetaDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmTarjetaDeb, False)
        Me.FrmTarjetaDeb.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_0)
        Me.FrmTarjetaDeb.Controls.Add(Me._optTarjetaDebito_1)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmTarjetaDeb, "Default")
        Me.FrmTarjetaDeb.ForeColor = System.Drawing.Color.Navy
        Me.FrmTarjetaDeb.Location = New System.Drawing.Point(459, 78)
        Me.FrmTarjetaDeb.Name = "FrmTarjetaDeb"
        Me.FrmTarjetaDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmTarjetaDeb.Size = New System.Drawing.Size(169, 21)
        Me.FrmTarjetaDeb.TabIndex = 39
        Me.FrmTarjetaDeb.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmTarjetaDeb, "")
        '
        '_optTarjetaDebito_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_0, False)
        Me._optTarjetaDebito_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_0, "Default")
        Me._optTarjetaDebito_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_0.Enabled = False
        Me._optTarjetaDebito_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_0.Location = New System.Drawing.Point(44, 1)
        Me._optTarjetaDebito_0.Name = "_optTarjetaDebito_0"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_0, "5118")
        Me._optTarjetaDebito_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_0.Size = New System.Drawing.Size(41, 17)
        Me._optTarjetaDebito_0.TabIndex = 3
        Me._optTarjetaDebito_0.TabStop = True
        Me._optTarjetaDebito_0.Text = "*Si"
        Me._optTarjetaDebito_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_0, "")
        '
        '_optTarjetaDebito_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTarjetaDebito_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTarjetaDebito_1, False)
        Me._optTarjetaDebito_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTarjetaDebito_1, "Default")
        Me._optTarjetaDebito_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTarjetaDebito_1.Enabled = False
        Me._optTarjetaDebito_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optTarjetaDebito_1.Location = New System.Drawing.Point(91, 1)
        Me._optTarjetaDebito_1.Name = "_optTarjetaDebito_1"
        Me.COBISResourceProvider.SetResourceID(Me._optTarjetaDebito_1, "5119")
        Me._optTarjetaDebito_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTarjetaDebito_1.Size = New System.Drawing.Size(53, 17)
        Me._optTarjetaDebito_1.TabIndex = 3
        Me._optTarjetaDebito_1.TabStop = True
        Me._optTarjetaDebito_1.Text = "*No"
        Me._optTarjetaDebito_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTarjetaDebito_1, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_11)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_15)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox1.Controls.Add(Me.mskCuenta)
        Me.UltraGroupBox1.Controls.Add(Me._mskValor_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._mskValor_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_5)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(638, 85)
        Me.UltraGroupBox1.TabIndex = 0
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblEtiqueta_13.Controls.Add(Me.grdEstado)
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(10, 253)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "500645")
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(638, 192)
        Me._lblEtiqueta_13.TabIndex = 2
        Me._lblEtiqueta_13.Text = "*Transacciones:"
        Me._lblEtiqueta_13.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBImprimir, Me.TSBFirma, Me.TSBSiguientes, Me.TSBTransmitir, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(677, 25)
        Me.TSBotones.TabIndex = 43
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Black
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(71, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBFirma
        '
        Me.TSBFirma.ForeColor = System.Drawing.Color.Black
        Me.TSBFirma.Image = CType(resources.GetObject("TSBFirma.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBFirma, "2027")
        Me.TSBFirma.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBFirma.Name = "TSBFirma"
        Me.COBISResourceProvider.SetResourceID(Me.TSBFirma, "2027")
        Me.TSBFirma.Size = New System.Drawing.Size(59, 22)
        Me.TSBFirma.Text = "*&Firma"
        Me.TSBFirma.Visible = False
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2040")
        Me.TSBSiguientes.Size = New System.Drawing.Size(82, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(80, 22)
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
        Me.TSBLimpiar.Size = New System.Drawing.Size(66, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.Color.Black
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "2068")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
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
        Me._cmdBoton_7.Enabled = False
        Me._cmdBoton_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_7.Location = New System.Drawing.Point(-700, 158)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 44
        Me._cmdBoton_7.TabStop = False
        Me._cmdBoton_7.Tag = "6335"
        Me._cmdBoton_7.Text = "*&Excel"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        'FTran232Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_7)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(80, 155)
        Me.Name = "FTran232Class"
        Me.COBISResourceProvider.SetResourceID(Me, "3075")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(677, 501)
        Me.Tag = "3117"
        Me.Text = "*Consulta de Movimientos de Cuentas de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdEstado, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.FrmTarjetaDeb, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmTarjetaDeb.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me._lblEtiqueta_13, System.ComponentModel.ISupportInitialize).EndInit()
        Me._lblEtiqueta_13.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptTarjetaDebito()
        Me.optTarjetaDebito(0) = _optTarjetaDebito_0
        Me.optTarjetaDebito(1) = _optTarjetaDebito_1
    End Sub
    Sub InitializemskValor()
        Me.mskValor(1) = _mskValor_1
        Me.mskValor(0) = _mskValor_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(15) = _lblEtiqueta_15
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        'Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(3) = _lblEtiqueta_3
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(7) = _cmdBoton_7
    End Sub

    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBFirma As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents _lblEtiqueta_13 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents FrmTarjetaDeb As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optTarjetaDebito_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optTarjetaDebito_1 As System.Windows.Forms.RadioButton
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
#End Region
End Class


