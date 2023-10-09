Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FMantenimientoCBClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializelblEtiqueta()
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
    Public WithEvents grdCorresponsales As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents txtEstado As System.Windows.Forms.TextBox
    Public WithEvents txtNumContrato As System.Windows.Forms.TextBox
    Public WithEvents txtCodRed As System.Windows.Forms.TextBox
    Public WithEvents txtCorresponsal As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents mskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskCuentaCupo As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskCuentaComision As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Public WithEvents lblEstado As System.Windows.Forms.Label
    Public WithEvents lblDescRegimen As System.Windows.Forms.Label
    Public WithEvents lblDescCiudad As System.Windows.Forms.Label
    Public WithEvents lblDescDepto As System.Windows.Forms.Label
    Public WithEvents lblRegimen As System.Windows.Forms.Label
    Public WithEvents lblCiudad As System.Windows.Forms.Label
    Public WithEvents lblDepartamento As System.Windows.Forms.Label
    Public WithEvents lblNumDocDig As System.Windows.Forms.Label
    Public WithEvents lblNumDoc As System.Windows.Forms.Label
    Public WithEvents lblDescTipoDoc As System.Windows.Forms.Label
    Public WithEvents lblTipoDoc As System.Windows.Forms.Label
    Public WithEvents lblCorresponsal As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Public cmdBoton(5) As System.Windows.Forms.Button
	Public lblEtiqueta(12) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FMantenimientoCBClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.grdCorresponsales = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.txtEstado = New System.Windows.Forms.TextBox()
        Me.txtNumContrato = New System.Windows.Forms.TextBox()
        Me.txtCodRed = New System.Windows.Forms.TextBox()
        Me.txtCorresponsal = New System.Windows.Forms.TextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.mskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskCuentaCupo = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskCuentaComision = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me.lblDescRegimen = New System.Windows.Forms.Label()
        Me.lblDescCiudad = New System.Windows.Forms.Label()
        Me.lblDescDepto = New System.Windows.Forms.Label()
        Me.lblRegimen = New System.Windows.Forms.Label()
        Me.lblCiudad = New System.Windows.Forms.Label()
        Me.lblDepartamento = New System.Windows.Forms.Label()
        Me.lblNumDocDig = New System.Windows.Forms.Label()
        Me.lblNumDoc = New System.Windows.Forms.Label()
        Me.lblDescTipoDoc = New System.Windows.Forms.Label()
        Me.lblTipoDoc = New System.Windows.Forms.Label()
        Me.lblCorresponsal = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBPuntos = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdCorresponsales, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'grdCorresponsales
        '
        Me.grdCorresponsales._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCorresponsales, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCorresponsales, False)
        Me.grdCorresponsales.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdCorresponsales.Clip = ""
        Me.grdCorresponsales.Col = CType(1, Short)
        Me.grdCorresponsales.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdCorresponsales.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdCorresponsales.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdCorresponsales, "Default")
        Me.grdCorresponsales.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdCorresponsales, True)
        Me.grdCorresponsales.FixedCols = CType(1, Short)
        Me.grdCorresponsales.FixedRows = CType(1, Short)
        Me.grdCorresponsales.ForeColor = System.Drawing.Color.Black
        Me.grdCorresponsales.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdCorresponsales.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdCorresponsales.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdCorresponsales.HighLight = True
        Me.grdCorresponsales.Location = New System.Drawing.Point(10, 226)
        Me.grdCorresponsales.Name = "grdCorresponsales"
        Me.grdCorresponsales.Picture = Nothing
        Me.grdCorresponsales.Row = CType(1, Short)
        Me.grdCorresponsales.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdCorresponsales.Size = New System.Drawing.Size(540, 225)
        Me.grdCorresponsales.Sort = CType(2, Short)
        Me.grdCorresponsales.TabIndex = 36
        Me.grdCorresponsales.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCorresponsales, "")
        '
        'txtEstado
        '
        Me.txtEstado.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtEstado, False)
        Me.txtEstado.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtEstado, "Default")
        Me.txtEstado.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtEstado.Location = New System.Drawing.Point(403, 150)
        Me.txtEstado.MaxLength = 10
        Me.txtEstado.Name = "txtEstado"
        Me.txtEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtEstado.Size = New System.Drawing.Size(41, 20)
        Me.txtEstado.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtEstado, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtEstado, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtEstado, False)
        '
        'txtNumContrato
        '
        Me.txtNumContrato.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNumContrato, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNumContrato, False)
        Me.txtNumContrato.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtNumContrato, "Default")
        Me.txtNumContrato.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNumContrato.Location = New System.Drawing.Point(113, 173)
        Me.txtNumContrato.MaxLength = 10
        Me.txtNumContrato.Name = "txtNumContrato"
        Me.txtNumContrato.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNumContrato.Size = New System.Drawing.Size(121, 20)
        Me.txtNumContrato.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNumContrato, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtNumContrato, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtNumContrato, False)
        '
        'txtCodRed
        '
        Me.txtCodRed.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCodRed, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCodRed, False)
        Me.txtCodRed.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCodRed, "Default")
        Me.txtCodRed.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCodRed.Location = New System.Drawing.Point(113, 150)
        Me.txtCodRed.MaxLength = 10
        Me.txtCodRed.Name = "txtCodRed"
        Me.txtCodRed.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCodRed.Size = New System.Drawing.Size(121, 20)
        Me.txtCodRed.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCodRed, "")
        Me.COBISViewResizer.SetxIncrement(Me.txtCodRed, False)
        Me.COBISViewResizer.SetyIncrement(Me.txtCodRed, False)
        '
        'txtCorresponsal
        '
        Me.txtCorresponsal.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCorresponsal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCorresponsal, False)
        Me.txtCorresponsal.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCorresponsal, "Default")
        Me.txtCorresponsal.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCorresponsal.Location = New System.Drawing.Point(113, 10)
        Me.txtCorresponsal.MaxLength = 4
        Me.txtCorresponsal.Name = "txtCorresponsal"
        Me.txtCorresponsal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCorresponsal.Size = New System.Drawing.Size(51, 20)
        Me.txtCorresponsal.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCorresponsal, "")
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
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(-592, 120)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 9
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "&Transmitir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'mskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFecha, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFecha, "Default")
        Me.mskFecha.Length = CType(64, Short)
        Me.mskFecha.Location = New System.Drawing.Point(403, 173)
        Me.mskFecha.Mask = "##/##/####"
        Me.mskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFecha.MaxReal = 3.402823E+38!
        Me.mskFecha.MinReal = -3.402823E+38!
        Me.mskFecha.Name = "mskFecha"
        Me.mskFecha.Size = New System.Drawing.Size(147, 20)
        Me.mskFecha.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFecha, "")
        Me.COBISViewResizer.SetxIncrement(Me.mskFecha, False)
        Me.COBISViewResizer.SetyIncrement(Me.mskFecha, False)
        '
        'mskCuentaCupo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuentaCupo, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuentaCupo, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuentaCupo, "Default")
        Me.mskCuentaCupo.Length = CType(64, Short)
        Me.mskCuentaCupo.Location = New System.Drawing.Point(113, 196)
        Me.mskCuentaCupo.MaxReal = 3.402823E+38!
        Me.mskCuentaCupo.MinReal = -3.402823E+38!
        Me.mskCuentaCupo.Name = "mskCuentaCupo"
        Me.mskCuentaCupo.Size = New System.Drawing.Size(121, 20)
        Me.mskCuentaCupo.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuentaCupo, "")
        Me.COBISViewResizer.SetxIncrement(Me.mskCuentaCupo, False)
        Me.COBISViewResizer.SetyIncrement(Me.mskCuentaCupo, False)
        '
        'mskCuentaComision
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuentaComision, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuentaComision, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuentaComision, "Default")
        Me.mskCuentaComision.Length = CType(20, Short)
        Me.mskCuentaComision.Location = New System.Drawing.Point(403, 196)
        Me.mskCuentaComision.MaxReal = 3.402823E+38!
        Me.mskCuentaComision.MinReal = -3.402823E+38!
        Me.mskCuentaComision.Name = "mskCuentaComision"
        Me.mskCuentaComision.Size = New System.Drawing.Size(147, 20)
        Me.mskCuentaComision.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuentaComision, "")
        Me.COBISViewResizer.SetxIncrement(Me.mskCuentaComision, False)
        Me.COBISViewResizer.SetyIncrement(Me.mskCuentaComision, False)
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
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_3.Location = New System.Drawing.Point(-592, 176)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 10
        Me._cmdBoton_3.Tag = "386"
        Me._cmdBoton_3.Text = "&Puntos"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_0.Location = New System.Drawing.Point(-592, 8)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 7
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "388;389"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_1.Location = New System.Drawing.Point(-592, 64)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 8
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "388;389"
        Me._cmdBoton_1.Text = "Si&guiente"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_4.Location = New System.Drawing.Point(-592, 336)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 11
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "&Limpiar"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_5.Image = CType(resources.GetObject("_cmdBoton_5.Image"), System.Drawing.Image)
        Me._cmdBoton_5.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_5.Location = New System.Drawing.Point(-592, 392)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 12
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "&Salir"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Location = New System.Drawing.Point(447, 150)
        Me.lblEstado.Name = "lblEstado"
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(103, 20)
        Me.lblEstado.TabIndex = 37
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        Me.COBISViewResizer.SetxIncrement(Me.lblEstado, False)
        Me.COBISViewResizer.SetyIncrement(Me.lblEstado, False)
        '
        'lblDescRegimen
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescRegimen, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescRegimen, False)
        Me.lblDescRegimen.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescRegimen.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescRegimen, "Default")
        Me.lblDescRegimen.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescRegimen.Location = New System.Drawing.Point(167, 125)
        Me.lblDescRegimen.Name = "lblDescRegimen"
        Me.lblDescRegimen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescRegimen.Size = New System.Drawing.Size(383, 20)
        Me.lblDescRegimen.TabIndex = 35
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescRegimen, "")
        '
        'lblDescCiudad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescCiudad, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescCiudad, False)
        Me.lblDescCiudad.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescCiudad.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescCiudad, "Default")
        Me.lblDescCiudad.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescCiudad.Location = New System.Drawing.Point(167, 102)
        Me.lblDescCiudad.Name = "lblDescCiudad"
        Me.lblDescCiudad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescCiudad.Size = New System.Drawing.Size(383, 20)
        Me.lblDescCiudad.TabIndex = 34
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescCiudad, "")
        '
        'lblDescDepto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescDepto, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescDepto, False)
        Me.lblDescDepto.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescDepto.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescDepto, "Default")
        Me.lblDescDepto.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescDepto.Location = New System.Drawing.Point(167, 79)
        Me.lblDescDepto.Name = "lblDescDepto"
        Me.lblDescDepto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescDepto.Size = New System.Drawing.Size(383, 20)
        Me.lblDescDepto.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescDepto, "")
        '
        'lblRegimen
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblRegimen, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblRegimen, False)
        Me.lblRegimen.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblRegimen.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblRegimen, "Default")
        Me.lblRegimen.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblRegimen.Location = New System.Drawing.Point(113, 125)
        Me.lblRegimen.Name = "lblRegimen"
        Me.lblRegimen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblRegimen.Size = New System.Drawing.Size(51, 20)
        Me.lblRegimen.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblRegimen, "")
        '
        'lblCiudad
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCiudad, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCiudad, False)
        Me.lblCiudad.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCiudad.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCiudad, "Default")
        Me.lblCiudad.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCiudad.Location = New System.Drawing.Point(113, 102)
        Me.lblCiudad.Name = "lblCiudad"
        Me.lblCiudad.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCiudad.Size = New System.Drawing.Size(51, 20)
        Me.lblCiudad.TabIndex = 31
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCiudad, "")
        '
        'lblDepartamento
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDepartamento, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDepartamento, False)
        Me.lblDepartamento.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDepartamento.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDepartamento, "Default")
        Me.lblDepartamento.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDepartamento.Location = New System.Drawing.Point(113, 79)
        Me.lblDepartamento.Name = "lblDepartamento"
        Me.lblDepartamento.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDepartamento.Size = New System.Drawing.Size(51, 20)
        Me.lblDepartamento.TabIndex = 30
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDepartamento, "")
        '
        'lblNumDocDig
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNumDocDig, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNumDocDig, False)
        Me.lblNumDocDig.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNumDocDig.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNumDocDig, "Default")
        Me.lblNumDocDig.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNumDocDig.Location = New System.Drawing.Point(113, 457)
        Me.lblNumDocDig.Name = "lblNumDocDig"
        Me.lblNumDocDig.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNumDocDig.Size = New System.Drawing.Size(35, 20)
        Me.lblNumDocDig.TabIndex = 29
        Me.lblNumDocDig.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNumDocDig, "")
        Me.COBISViewResizer.SetxIncrement(Me.lblNumDocDig, False)
        Me.COBISViewResizer.SetyIncrement(Me.lblNumDocDig, False)
        '
        'lblNumDoc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNumDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNumDoc, False)
        Me.lblNumDoc.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNumDoc.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNumDoc, "Default")
        Me.lblNumDoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNumDoc.Location = New System.Drawing.Point(113, 56)
        Me.lblNumDoc.Name = "lblNumDoc"
        Me.lblNumDoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNumDoc.Size = New System.Drawing.Size(437, 20)
        Me.lblNumDoc.TabIndex = 28
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNumDoc, "")
        '
        'lblDescTipoDoc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescTipoDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescTipoDoc, False)
        Me.lblDescTipoDoc.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescTipoDoc.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescTipoDoc, "Default")
        Me.lblDescTipoDoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescTipoDoc.Location = New System.Drawing.Point(167, 33)
        Me.lblDescTipoDoc.Name = "lblDescTipoDoc"
        Me.lblDescTipoDoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescTipoDoc.Size = New System.Drawing.Size(383, 20)
        Me.lblDescTipoDoc.TabIndex = 27
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescTipoDoc, "")
        '
        'lblTipoDoc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTipoDoc, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTipoDoc, False)
        Me.lblTipoDoc.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblTipoDoc.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblTipoDoc, "Default")
        Me.lblTipoDoc.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTipoDoc.Location = New System.Drawing.Point(113, 33)
        Me.lblTipoDoc.Name = "lblTipoDoc"
        Me.lblTipoDoc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTipoDoc.Size = New System.Drawing.Size(51, 20)
        Me.lblTipoDoc.TabIndex = 26
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTipoDoc, "")
        '
        'lblCorresponsal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCorresponsal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCorresponsal, False)
        Me.lblCorresponsal.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCorresponsal.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCorresponsal, "Default")
        Me.lblCorresponsal.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCorresponsal.Location = New System.Drawing.Point(167, 10)
        Me.lblCorresponsal.Name = "lblCorresponsal"
        Me.lblCorresponsal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCorresponsal.Size = New System.Drawing.Size(383, 20)
        Me.lblCorresponsal.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCorresponsal, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(248, 196)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "508660")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(150, 20)
        Me._lblEtiqueta_12.TabIndex = 24
        Me._lblEtiqueta_12.Text = "*Nro Cuenta para Comisiones:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(248, 173)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "508575")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(150, 20)
        Me._lblEtiqueta_11.TabIndex = 23
        Me._lblEtiqueta_11.Text = "*Fecha Vencimiento Contrato:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(248, 150)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "5067")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(44, 20)
        Me._lblEtiqueta_10.TabIndex = 22
        Me._lblEtiqueta_10.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 196)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "508661")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(69, 20)
        Me._lblEtiqueta_9.TabIndex = 21
        Me._lblEtiqueta_9.Text = "*Nro Cuenta:"
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
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 173)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "508659")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_8.TabIndex = 20
        Me._lblEtiqueta_8.Text = "*Nro Contrato:"
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 150)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "508462")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(97, 20)
        Me._lblEtiqueta_7.TabIndex = 19
        Me._lblEtiqueta_7.Text = "*Cod Red:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 125)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "508710")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(91, 20)
        Me._lblEtiqueta_6.TabIndex = 18
        Me._lblEtiqueta_6.Text = "*Régimen Fiscal:"
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
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501907")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(44, 20)
        Me._lblEtiqueta_5.TabIndex = 17
        Me._lblEtiqueta_5.Text = "*Ciudad:"
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
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "5036")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(84, 20)
        Me._lblEtiqueta_4.TabIndex = 16
        Me._lblEtiqueta_4.Text = "*Departamento:"
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
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "508662")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(111, 20)
        Me._lblEtiqueta_3.TabIndex = 15
        Me._lblEtiqueta_3.Text = "*Nro Identificación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "2403")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(111, 20)
        Me._lblEtiqueta_2.TabIndex = 14
        Me._lblEtiqueta_2.Text = "*Tipo Identificación:"
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500334")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(78, 20)
        Me._lblEtiqueta_1.TabIndex = 13
        Me._lblEtiqueta_1.Text = "*Corresponsal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.grdCorresponsales)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me.txtEstado)
        Me.PFormas.Controls.Add(Me.txtNumContrato)
        Me.PFormas.Controls.Add(Me.txtCodRed)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me.txtCorresponsal)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me.mskFecha)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me.mskCuentaCupo)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_8)
        Me.PFormas.Controls.Add(Me.mskCuentaComision)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_9)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_10)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_11)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_12)
        Me.PFormas.Controls.Add(Me.lblCorresponsal)
        Me.PFormas.Controls.Add(Me.lblTipoDoc)
        Me.PFormas.Controls.Add(Me.lblEstado)
        Me.PFormas.Controls.Add(Me.lblDescTipoDoc)
        Me.PFormas.Controls.Add(Me.lblDescRegimen)
        Me.PFormas.Controls.Add(Me.lblNumDoc)
        Me.PFormas.Controls.Add(Me.lblDescCiudad)
        Me.PFormas.Controls.Add(Me.lblNumDocDig)
        Me.PFormas.Controls.Add(Me.lblDescDepto)
        Me.PFormas.Controls.Add(Me.lblDepartamento)
        Me.PFormas.Controls.Add(Me.lblRegimen)
        Me.PFormas.Controls.Add(Me.lblCiudad)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(561, 458)
        Me.PFormas.TabIndex = 38
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBTransmitir, Me.TSBPuntos, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(577, 25)
        Me.TSBotones.TabIndex = 39
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(62, 22)
        Me.TSBBuscar.Text = "&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500006")
        Me.TSBSiguiente.Size = New System.Drawing.Size(76, 22)
        Me.TSBSiguiente.Text = "Siguien&te"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(81, 22)
        Me.TSBTransmitir.Text = "&Transmitir"
        '
        'TSBPuntos
        '
        Me.TSBPuntos.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBPuntos.Image = CType(resources.GetObject("TSBPuntos.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBPuntos, "2005")
        Me.TSBPuntos.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBPuntos.Name = "TSBPuntos"
        Me.COBISResourceProvider.SetResourceID(Me.TSBPuntos, "508428")
        Me.TSBPuntos.Size = New System.Drawing.Size(64, 22)
        Me.TSBPuntos.Text = "&Puntos"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(67, 22)
        Me.TSBLimpiar.Text = "&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(49, 22)
        Me.TSBSalir.Text = "&Salir"
        '
        'FMantenimientoCBClass
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
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FMantenimientoCBClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(577, 499)
        Me.Text = "Mantenimiento de Corresponsal Bancario Red Posicionada"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdCorresponsales, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBPuntos As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


