Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FConsMovCBClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializemskFecha()
		InitializelblEtiqueta()
		InitializeLine1()
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
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskFecha_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskFecha_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents grdMovimientos As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents cmdSiguientes As System.Windows.Forms.Button
    Public WithEvents cmdTransmitir As System.Windows.Forms.Button
    Public WithEvents cmdLimpiar As System.Windows.Forms.Button
    Public WithEvents cmdSalir As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Public WithEvents lblDisponible As System.Windows.Forms.Label
    Public WithEvents lblFechaUltMov As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents lblMoneda As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Public WithEvents lblOficial As System.Windows.Forms.Label
    Public WithEvents lblNombre As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
	Public WithEvents lblEstado As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Public Line1(2) As System.Windows.Forms.Label
	Public lblEtiqueta(10) As System.Windows.Forms.Label
	Public mskFecha(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FConsMovCBClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskFecha_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskFecha_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.grdMovimientos = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.cmdSiguientes = New System.Windows.Forms.Button()
        Me.cmdTransmitir = New System.Windows.Forms.Button()
        Me.cmdLimpiar = New System.Windows.Forms.Button()
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me.lblDisponible = New System.Windows.Forms.Label()
        Me.lblFechaUltMov = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.lblMoneda = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me.lblOficial = New System.Windows.Forms.Label()
        Me.lblNombre = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdMovimientos, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(154, 10)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(146, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_mskFecha_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskFecha_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskFecha_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskFecha_1, "Default")
        Me._mskFecha_1.Length = CType(64, Short)
        Me._mskFecha_1.Location = New System.Drawing.Point(391, 56)
        Me._mskFecha_1.MaxReal = 3.402823E+38!
        Me._mskFecha_1.MinReal = -3.402823E+38!
        Me._mskFecha_1.Name = "_mskFecha_1"
        Me._mskFecha_1.Size = New System.Drawing.Size(121, 20)
        Me._mskFecha_1.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskFecha_1, "")
        '
        '_mskFecha_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskFecha_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskFecha_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskFecha_0, "Default")
        Me._mskFecha_0.Length = CType(64, Short)
        Me._mskFecha_0.Location = New System.Drawing.Point(154, 56)
        Me._mskFecha_0.MaxReal = 3.402823E+38!
        Me._mskFecha_0.MinReal = -3.402823E+38!
        Me._mskFecha_0.Name = "_mskFecha_0"
        Me._mskFecha_0.Size = New System.Drawing.Size(146, 20)
        Me._mskFecha_0.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskFecha_0, "")
        '
        'grdMovimientos
        '
        Me.grdMovimientos._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdMovimientos, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdMovimientos, False)
        Me.grdMovimientos.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdMovimientos.Clip = ""
        Me.grdMovimientos.Col = CType(1, Short)
        Me.grdMovimientos.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdMovimientos.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdMovimientos.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdMovimientos, "Default")
        Me.grdMovimientos.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdMovimientos, True)
        Me.grdMovimientos.FixedCols = CType(1, Short)
        Me.grdMovimientos.FixedRows = CType(1, Short)
        Me.grdMovimientos.ForeColor = System.Drawing.Color.Black
        Me.grdMovimientos.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdMovimientos.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdMovimientos.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdMovimientos.HighLight = True
        Me.grdMovimientos.Location = New System.Drawing.Point(6, 19)
        Me.grdMovimientos.Name = "grdMovimientos"
        Me.grdMovimientos.Picture = Nothing
        Me.grdMovimientos.Row = CType(1, Short)
        Me.grdMovimientos.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdMovimientos.Size = New System.Drawing.Size(496, 184)
        Me.grdMovimientos.Sort = CType(2, Short)
        Me.grdMovimientos.TabIndex = 9
        Me.grdMovimientos.TabStop = False
        Me.grdMovimientos.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdMovimientos, "")
        '
        'cmdSiguientes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSiguientes, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSiguientes, False)
        Me.cmdSiguientes.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSiguientes, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSiguientes, True)
        Me.cmdSiguientes.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSiguientes, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSiguientes, Nothing)
        Me.cmdSiguientes.Enabled = False
        Me.cmdSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSiguientes.Location = New System.Drawing.Point(-628, 172)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSiguientes, System.Drawing.Color.Silver)
        Me.cmdSiguientes.Name = "cmdSiguientes"
        Me.cmdSiguientes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSiguientes.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSiguientes, 1)
        Me.cmdSiguientes.TabIndex = 10
        Me.cmdSiguientes.Text = "*Siguien&tes"
        Me.cmdSiguientes.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSiguientes.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSiguientes, "")
        '
        'cmdTransmitir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdTransmitir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdTransmitir, False)
        Me.cmdTransmitir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdTransmitir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdTransmitir, True)
        Me.cmdTransmitir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdTransmitir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdTransmitir, Nothing)
        Me.cmdTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdTransmitir.Location = New System.Drawing.Point(-628, 223)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdTransmitir, System.Drawing.Color.Silver)
        Me.cmdTransmitir.Name = "cmdTransmitir"
        Me.cmdTransmitir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdTransmitir.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdTransmitir, 1)
        Me.cmdTransmitir.TabIndex = 11
        Me.cmdTransmitir.Text = "*&Transmitir"
        Me.cmdTransmitir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdTransmitir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdTransmitir, "")
        '
        'cmdLimpiar
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdLimpiar, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdLimpiar, False)
        Me.cmdLimpiar.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdLimpiar, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdLimpiar, True)
        Me.cmdLimpiar.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdLimpiar, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdLimpiar, Nothing)
        Me.cmdLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdLimpiar.Location = New System.Drawing.Point(-628, 274)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdLimpiar, System.Drawing.Color.Silver)
        Me.cmdLimpiar.Name = "cmdLimpiar"
        Me.cmdLimpiar.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdLimpiar.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdLimpiar, 1)
        Me.cmdLimpiar.TabIndex = 12
        Me.cmdLimpiar.Text = "*&Limpiar"
        Me.cmdLimpiar.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdLimpiar.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdLimpiar, "")
        '
        'cmdSalir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSalir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSalir, False)
        Me.cmdSalir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSalir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir, True)
        Me.cmdSalir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir, Nothing)
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Location = New System.Drawing.Point(-628, 325)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 13
        Me.cmdSalir.Text = "*&Salir"
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 125)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "508492")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(121, 20)
        Me._lblEtiqueta_9.TabIndex = 22
        Me._lblEtiqueta_9.Text = "*Cupo Disponible:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        'lblDisponible
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDisponible, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDisponible, False)
        Me.lblDisponible.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDisponible.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDisponible, "Default")
        Me.lblDisponible.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDisponible.Location = New System.Drawing.Point(154, 125)
        Me.lblDisponible.Name = "lblDisponible"
        Me.lblDisponible.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDisponible.Size = New System.Drawing.Size(146, 20)
        Me.lblDisponible.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDisponible, "")
        '
        'lblFechaUltMov
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblFechaUltMov, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblFechaUltMov, False)
        Me.lblFechaUltMov.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblFechaUltMov.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblFechaUltMov, "Default")
        Me.lblFechaUltMov.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFechaUltMov.Location = New System.Drawing.Point(154, 79)
        Me.lblFechaUltMov.Name = "lblFechaUltMov"
        Me.lblFechaUltMov.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFechaUltMov.Size = New System.Drawing.Size(146, 20)
        Me.lblFechaUltMov.TabIndex = 5
        Me.lblFechaUltMov.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblFechaUltMov, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500822")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(130, 20)
        Me._lblEtiqueta_6.TabIndex = 21
        Me._lblEtiqueta_6.Text = "*Fecha Ultimo Mov.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'lblMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblMoneda, False)
        Me.lblMoneda.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblMoneda.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblMoneda, "Default")
        Me.lblMoneda.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblMoneda.Location = New System.Drawing.Point(391, 102)
        Me.lblMoneda.Name = "lblMoneda"
        Me.lblMoneda.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblMoneda.Size = New System.Drawing.Size(121, 20)
        Me.lblMoneda.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblMoneda, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(306, 102)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "5209")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(66, 20)
        Me._lblEtiqueta_8.TabIndex = 20
        Me._lblEtiqueta_8.Text = "*Moneda:"
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "508680")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(121, 17)
        Me._lblEtiqueta_7.TabIndex = 19
        Me._lblEtiqueta_7.Text = "*Oficial de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        'lblOficial
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOficial, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOficial, False)
        Me.lblOficial.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOficial.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOficial, "Default")
        Me.lblOficial.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOficial.Location = New System.Drawing.Point(154, 102)
        Me.lblOficial.Name = "lblOficial"
        Me.lblOficial.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOficial.Size = New System.Drawing.Size(146, 20)
        Me.lblOficial.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOficial, "")
        '
        'lblNombre
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNombre, False)
        Me.lblNombre.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNombre.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNombre, "Default")
        Me.lblNombre.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNombre.Location = New System.Drawing.Point(154, 33)
        Me.lblNombre.Name = "lblNombre"
        Me.lblNombre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNombre.Size = New System.Drawing.Size(358, 20)
        Me.lblNombre.TabIndex = 2
        Me.lblNombre.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNombre, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "500334")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(97, 20)
        Me._lblEtiqueta_3.TabIndex = 18
        Me._lblEtiqueta_3.Text = "*Corresponsal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(306, 56)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501499")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(89, 20)
        Me._lblEtiqueta_5.TabIndex = 17
        Me._lblEtiqueta_5.Text = "*Fecha Hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "508568")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(97, 20)
        Me._lblEtiqueta_4.TabIndex = 16
        Me._lblEtiqueta_4.Text = "*Fecha Desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Location = New System.Drawing.Point(391, 10)
        Me.lblEstado.Name = "lblEstado"
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(121, 20)
        Me.lblEstado.TabIndex = 1
        Me.lblEstado.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(306, 10)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "508560")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(89, 20)
        Me._lblEtiqueta_2.TabIndex = 15
        Me._lblEtiqueta_2.Text = "*Estado Red:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501874")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(154, 20)
        Me._lblEtiqueta_1.TabIndex = 14
        Me._lblEtiqueta_1.Text = "*No. de Cuenta Ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._mskFecha_1)
        Me.PFormas.Controls.Add(Me.lblEstado)
        Me.PFormas.Controls.Add(Me._mskFecha_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me.cmdSiguientes)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.PFormas.Controls.Add(Me.cmdTransmitir)
        Me.PFormas.Controls.Add(Me.lblNombre)
        Me.PFormas.Controls.Add(Me.cmdLimpiar)
        Me.PFormas.Controls.Add(Me.lblOficial)
        Me.PFormas.Controls.Add(Me.cmdSalir)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_8)
        Me.PFormas.Controls.Add(Me.lblMoneda)
        Me.PFormas.Controls.Add(Me.lblDisponible)
        Me.PFormas.Controls.Add(Me.lblFechaUltMov)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_9)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(523, 378)
        Me.PFormas.TabIndex = 24
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdMovimientos)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 164)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "2323")
        Me.GroupBox1.Size = New System.Drawing.Size(512, 209)
        Me.GroupBox1.TabIndex = 24
        Me.GroupBox1.Text = "*Transacciones"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBSiguientes, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(537, 25)
        Me.TSBotones.TabIndex = 25
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
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Navy
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
        'FConsMovCBClass
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
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.COBISResourceProvider.SetImageID(Me, "2001")
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FConsMovCBClass"
        Me.COBISResourceProvider.SetResourceID(Me, "2001")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(537, 415)
        Me.Text = "Consulta de Movimientos de Cuenta de Corresponsal Bancario"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdMovimientos, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializemskFecha()
        Me.mskFecha(1) = _mskFecha_1
        Me.mskFecha(0) = _mskFecha_0
    End Sub
    Sub InitializelblEtiqueta()
        ' Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
    End Sub
    Sub InitializeLine1()
        'Me.Line1(2) = _Line1_2
        'Me.Line1(0) = _Line1_0
        'Me.Line1(1) = _Line1_1
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


