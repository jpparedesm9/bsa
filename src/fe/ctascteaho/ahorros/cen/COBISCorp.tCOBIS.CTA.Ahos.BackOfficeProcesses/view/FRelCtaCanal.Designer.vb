Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FRelCtaCanalClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializelblTitulo()
		InitializelblTelCelular()
		InitializelblRelEstado()
        'InitializelblPropietarios()
		InitializelblProducto()
		InitializelblProdBanc()
		InitializelblNomCuenta()
		InitializelblDescRelEstado()
		InitializelblDescProdBanc()
		InitializelblDescCategoria()
		InitializelblDescCanal()
		InitializelblCuentaDesc()
		InitializelblCuenta()
		InitializelblCategoria()
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
    Public WithEvents cmbProducto As System.Windows.Forms.ComboBox
    Public WithEvents txtMotivo As System.Windows.Forms.TextBox
    Public WithEvents cmdResetClave As System.Windows.Forms.Button
    Public WithEvents txtCanal As System.Windows.Forms.TextBox
    Public WithEvents txtTelCelular As System.Windows.Forms.TextBox
    Public WithEvents txtConfirmaTarjDeb As System.Windows.Forms.TextBox
    Public WithEvents txtTarjetaDebito As System.Windows.Forms.TextBox
    Public WithEvents grdRelacionCanal As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents TxtNuevaTarjeta As System.Windows.Forms.TextBox
    Public WithEvents lblDescMotivo As System.Windows.Forms.Label
    Public WithEvents lblMotivo As System.Windows.Forms.Label
    Private WithEvents _lblDescCanal_0 As System.Windows.Forms.Label
    Public WithEvents LblCanal As System.Windows.Forms.Label
    Private WithEvents _lblDescRelEstado_7 As System.Windows.Forms.Label
    Private WithEvents _lblTelCelular_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescCategoria_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescProdBanc_5 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_9 As System.Windows.Forms.Label
    Private WithEvents _lblRelEstado_3 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_1 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_8 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_7 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_5 As System.Windows.Forms.Label
    Private WithEvents _lblProdBanc_2 As System.Windows.Forms.Label
    Private WithEvents _lblCategoria_1 As System.Windows.Forms.Label
    Private WithEvents _lblTitulo_2 As System.Windows.Forms.Label
    Public WithEvents frmDatosCanales As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _lblProducto_10 As System.Windows.Forms.Label
    Private WithEvents _lblNomCuenta_6 As System.Windows.Forms.Label
    Private WithEvents _lblCuenta_0 As System.Windows.Forms.Label
    Private WithEvents _lblCuentaDesc_0 As System.Windows.Forms.Label
	Public Line1(2) As System.Windows.Forms.Label
	Public cmdBoton(5) As System.Windows.Forms.Button
	Public lblCategoria(1) As System.Windows.Forms.Label
	Public lblCuenta(0) As System.Windows.Forms.Label
	Public lblCuentaDesc(0) As System.Windows.Forms.Label
	Public lblDescCanal(0) As System.Windows.Forms.Label
	Public lblDescCategoria(6) As System.Windows.Forms.Label
	Public lblDescProdBanc(5) As System.Windows.Forms.Label
	Public lblDescRelEstado(7) As System.Windows.Forms.Label
	Public lblNomCuenta(6) As System.Windows.Forms.Label
	Public lblProdBanc(2) As System.Windows.Forms.Label
	Public lblProducto(10) As System.Windows.Forms.Label
	Public lblPropietarios(4) As System.Windows.Forms.Label
	Public lblRelEstado(3) As System.Windows.Forms.Label
	Public lblTelCelular(9) As System.Windows.Forms.Label
	Public lblTitulo(9) As System.Windows.Forms.Label
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FRelCtaCanalClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmbProducto = New System.Windows.Forms.ComboBox()
        Me.frmDatosCanales = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtMotivo = New System.Windows.Forms.TextBox()
        Me.txtCanal = New System.Windows.Forms.TextBox()
        Me.txtTelCelular = New System.Windows.Forms.TextBox()
        Me.txtConfirmaTarjDeb = New System.Windows.Forms.TextBox()
        Me.txtTarjetaDebito = New System.Windows.Forms.TextBox()
        Me.grdRelacionCanal = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.TxtNuevaTarjeta = New System.Windows.Forms.TextBox()
        Me.lblDescMotivo = New System.Windows.Forms.Label()
        Me.lblMotivo = New System.Windows.Forms.Label()
        Me._lblDescCanal_0 = New System.Windows.Forms.Label()
        Me.LblCanal = New System.Windows.Forms.Label()
        Me._lblDescRelEstado_7 = New System.Windows.Forms.Label()
        Me._lblTelCelular_9 = New System.Windows.Forms.Label()
        Me._lblDescCategoria_6 = New System.Windows.Forms.Label()
        Me._lblDescProdBanc_5 = New System.Windows.Forms.Label()
        Me._lblTitulo_9 = New System.Windows.Forms.Label()
        Me._lblRelEstado_3 = New System.Windows.Forms.Label()
        Me._lblTitulo_1 = New System.Windows.Forms.Label()
        Me._lblTitulo_8 = New System.Windows.Forms.Label()
        Me._lblTitulo_7 = New System.Windows.Forms.Label()
        Me._lblTitulo_5 = New System.Windows.Forms.Label()
        Me._lblProdBanc_2 = New System.Windows.Forms.Label()
        Me._lblCategoria_1 = New System.Windows.Forms.Label()
        Me._lblTitulo_2 = New System.Windows.Forms.Label()
        Me.cmdResetClave = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._lblProducto_10 = New System.Windows.Forms.Label()
        Me._lblNomCuenta_6 = New System.Windows.Forms.Label()
        Me._lblCuenta_0 = New System.Windows.Forms.Label()
        Me._lblCuentaDesc_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TBSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.TSBGenerar = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.frmDatosCanales, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmDatosCanales.SuspendLayout()
        CType(Me.grdRelacionCanal, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TBSBotones.SuspendLayout()
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
        'cmbProducto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbProducto, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbProducto, False)
        Me.cmbProducto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbProducto, "Default")
        Me.cmbProducto.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbProducto.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbProducto.Location = New System.Drawing.Point(146, 10)
        Me.cmbProducto.Name = "cmbProducto"
        Me.cmbProducto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbProducto.Size = New System.Drawing.Size(169, 21)
        Me.cmbProducto.TabIndex = 0
        Me.cmbProducto.Text = "cmbProducto"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbProducto, "")
        '
        'frmDatosCanales
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmDatosCanales, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmDatosCanales, False)
        Me.frmDatosCanales.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmDatosCanales.Controls.Add(Me.txtMotivo)
        Me.frmDatosCanales.Controls.Add(Me.txtCanal)
        Me.frmDatosCanales.Controls.Add(Me.txtTelCelular)
        Me.frmDatosCanales.Controls.Add(Me.txtConfirmaTarjDeb)
        Me.frmDatosCanales.Controls.Add(Me.txtTarjetaDebito)
        Me.frmDatosCanales.Controls.Add(Me.grdRelacionCanal)
        Me.frmDatosCanales.Controls.Add(Me.TxtNuevaTarjeta)
        Me.frmDatosCanales.Controls.Add(Me.lblDescMotivo)
        Me.frmDatosCanales.Controls.Add(Me.lblMotivo)
        Me.frmDatosCanales.Controls.Add(Me._lblDescCanal_0)
        Me.frmDatosCanales.Controls.Add(Me.LblCanal)
        Me.frmDatosCanales.Controls.Add(Me._lblDescRelEstado_7)
        Me.frmDatosCanales.Controls.Add(Me._lblTelCelular_9)
        Me.frmDatosCanales.Controls.Add(Me._lblDescCategoria_6)
        Me.frmDatosCanales.Controls.Add(Me._lblDescProdBanc_5)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_9)
        Me.frmDatosCanales.Controls.Add(Me._lblRelEstado_3)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_1)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_8)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_7)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_5)
        Me.frmDatosCanales.Controls.Add(Me._lblProdBanc_2)
        Me.frmDatosCanales.Controls.Add(Me._lblCategoria_1)
        Me.frmDatosCanales.Controls.Add(Me._lblTitulo_2)
        Me.COBISStyleProvider.SetControlStyle(Me.frmDatosCanales, "Default")
        Me.frmDatosCanales.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmDatosCanales.ForeColor = System.Drawing.Color.Navy
        Me.frmDatosCanales.Location = New System.Drawing.Point(10, 180)
        Me.frmDatosCanales.Name = "frmDatosCanales"
        Me.COBISResourceProvider.SetResourceID(Me.frmDatosCanales, "2203")
        Me.frmDatosCanales.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmDatosCanales.Size = New System.Drawing.Size(547, 277)
        Me.frmDatosCanales.TabIndex = 21
        Me.frmDatosCanales.Text = "*Datos de la Relacion Canales"
        Me.frmDatosCanales.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmDatosCanales, "")
        '
        'txtMotivo
        '
        Me.txtMotivo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtMotivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtMotivo, False)
        Me.txtMotivo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtMotivo, "Default")
        Me.txtMotivo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtMotivo.Enabled = False
        Me.txtMotivo.Location = New System.Drawing.Point(183, 85)
        Me.txtMotivo.MaxLength = 54
        Me.txtMotivo.Name = "txtMotivo"
        Me.txtMotivo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtMotivo.Size = New System.Drawing.Size(50, 20)
        Me.txtMotivo.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtMotivo, "")
        '
        'txtCanal
        '
        Me.txtCanal.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCanal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCanal, False)
        Me.txtCanal.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCanal, "Default")
        Me.txtCanal.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCanal.Location = New System.Drawing.Point(183, 63)
        Me.txtCanal.MaxLength = 4
        Me.txtCanal.Name = "txtCanal"
        Me.txtCanal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCanal.Size = New System.Drawing.Size(50, 20)
        Me.txtCanal.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCanal, "")
        '
        'txtTelCelular
        '
        Me.txtTelCelular.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTelCelular, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTelCelular, False)
        Me.txtTelCelular.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtTelCelular, "Default")
        Me.txtTelCelular.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTelCelular.Location = New System.Drawing.Point(183, 107)
        Me.txtTelCelular.MaxLength = 2
        Me.txtTelCelular.Name = "txtTelCelular"
        Me.txtTelCelular.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTelCelular.Size = New System.Drawing.Size(50, 20)
        Me.txtTelCelular.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTelCelular, "")
        '
        'txtConfirmaTarjDeb
        '
        Me.txtConfirmaTarjDeb.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtConfirmaTarjDeb, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtConfirmaTarjDeb, False)
        Me.txtConfirmaTarjDeb.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtConfirmaTarjDeb, "Default")
        Me.txtConfirmaTarjDeb.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtConfirmaTarjDeb.Location = New System.Drawing.Point(183, 151)
        Me.txtConfirmaTarjDeb.MaxLength = 19
        Me.txtConfirmaTarjDeb.Name = "txtConfirmaTarjDeb"
        Me.txtConfirmaTarjDeb.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtConfirmaTarjDeb.Size = New System.Drawing.Size(188, 20)
        Me.txtConfirmaTarjDeb.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtConfirmaTarjDeb, "")
        '
        'txtTarjetaDebito
        '
        Me.txtTarjetaDebito.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTarjetaDebito, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTarjetaDebito, False)
        Me.txtTarjetaDebito.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtTarjetaDebito, "Default")
        Me.txtTarjetaDebito.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTarjetaDebito.Location = New System.Drawing.Point(183, 129)
        Me.txtTarjetaDebito.MaxLength = 19
        Me.txtTarjetaDebito.Name = "txtTarjetaDebito"
        Me.txtTarjetaDebito.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTarjetaDebito.Size = New System.Drawing.Size(188, 20)
        Me.txtTarjetaDebito.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTarjetaDebito, "")
        '
        'grdRelacionCanal
        '
        Me.grdRelacionCanal._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRelacionCanal, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRelacionCanal, False)
        Me.grdRelacionCanal.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRelacionCanal.Clip = ""
        Me.grdRelacionCanal.Col = CType(1, Short)
        Me.grdRelacionCanal.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRelacionCanal.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRelacionCanal.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRelacionCanal, "Default")
        Me.grdRelacionCanal.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRelacionCanal, True)
        Me.grdRelacionCanal.FixedCols = CType(1, Short)
        Me.grdRelacionCanal.FixedRows = CType(1, Short)
        Me.grdRelacionCanal.ForeColor = System.Drawing.Color.Black
        Me.grdRelacionCanal.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRelacionCanal.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRelacionCanal.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRelacionCanal.HighLight = True
        Me.grdRelacionCanal.Location = New System.Drawing.Point(10, 198)
        Me.grdRelacionCanal.Name = "grdRelacionCanal"
        Me.grdRelacionCanal.Picture = Nothing
        Me.grdRelacionCanal.Row = CType(1, Short)
        Me.grdRelacionCanal.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRelacionCanal.Size = New System.Drawing.Size(530, 65)
        Me.grdRelacionCanal.Sort = CType(2, Short)
        Me.grdRelacionCanal.TabIndex = 28
        Me.grdRelacionCanal.TabStop = False
        Me.grdRelacionCanal.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRelacionCanal, "")
        '
        'TxtNuevaTarjeta
        '
        Me.TxtNuevaTarjeta.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.TxtNuevaTarjeta, False)
        Me.COBISViewResizer.SetAutoResize(Me.TxtNuevaTarjeta, False)
        Me.TxtNuevaTarjeta.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.TxtNuevaTarjeta, "Default")
        Me.TxtNuevaTarjeta.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TxtNuevaTarjeta.Location = New System.Drawing.Point(136, 233)
        Me.TxtNuevaTarjeta.MaxLength = 54
        Me.TxtNuevaTarjeta.Name = "TxtNuevaTarjeta"
        Me.TxtNuevaTarjeta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TxtNuevaTarjeta.Size = New System.Drawing.Size(188, 20)
        Me.TxtNuevaTarjeta.TabIndex = 39
        Me.TxtNuevaTarjeta.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TxtNuevaTarjeta, "")
        Me.COBISViewResizer.SetxIncrement(Me.TxtNuevaTarjeta, False)
        Me.COBISViewResizer.SetyIncrement(Me.TxtNuevaTarjeta, False)
        '
        'lblDescMotivo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescMotivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescMotivo, False)
        Me.lblDescMotivo.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescMotivo.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescMotivo, "Default")
        Me.lblDescMotivo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescMotivo.Location = New System.Drawing.Point(235, 85)
        Me.lblDescMotivo.Name = "lblDescMotivo"
        Me.lblDescMotivo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescMotivo.Size = New System.Drawing.Size(305, 20)
        Me.lblDescMotivo.TabIndex = 38
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescMotivo, "")
        '
        'lblMotivo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblMotivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblMotivo, False)
        Me.lblMotivo.AutoSize = True
        Me.lblMotivo.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblMotivo, "Default")
        Me.lblMotivo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblMotivo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblMotivo.ForeColor = System.Drawing.Color.Navy
        Me.lblMotivo.Location = New System.Drawing.Point(11, 85)
        Me.lblMotivo.Name = "lblMotivo"
        Me.COBISResourceProvider.SetResourceID(Me.lblMotivo, "2204")
        Me.lblMotivo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblMotivo.Size = New System.Drawing.Size(46, 13)
        Me.lblMotivo.TabIndex = 37
        Me.lblMotivo.Text = "*Motivo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblMotivo, "")
        '
        '_lblDescCanal_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescCanal_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescCanal_0, False)
        Me._lblDescCanal_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescCanal_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescCanal_0, "Default")
        Me._lblDescCanal_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescCanal_0.Location = New System.Drawing.Point(235, 63)
        Me._lblDescCanal_0.Name = "_lblDescCanal_0"
        Me._lblDescCanal_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescCanal_0.Size = New System.Drawing.Size(305, 20)
        Me._lblDescCanal_0.TabIndex = 35
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescCanal_0, "")
        '
        'LblCanal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblCanal, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblCanal, False)
        Me.LblCanal.AutoSize = True
        Me.LblCanal.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.LblCanal, "Default")
        Me.LblCanal.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblCanal.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.LblCanal.ForeColor = System.Drawing.Color.Navy
        Me.LblCanal.Location = New System.Drawing.Point(10, 63)
        Me.LblCanal.Name = "LblCanal"
        Me.COBISResourceProvider.SetResourceID(Me.LblCanal, "5224")
        Me.LblCanal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblCanal.Size = New System.Drawing.Size(41, 13)
        Me.LblCanal.TabIndex = 34
        Me.LblCanal.Text = "*Canal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblCanal, "")
        '
        '_lblDescRelEstado_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescRelEstado_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescRelEstado_7, False)
        Me._lblDescRelEstado_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescRelEstado_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescRelEstado_7, "Default")
        Me._lblDescRelEstado_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescRelEstado_7.Location = New System.Drawing.Point(235, 173)
        Me._lblDescRelEstado_7.Name = "_lblDescRelEstado_7"
        Me._lblDescRelEstado_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescRelEstado_7.Size = New System.Drawing.Size(137, 20)
        Me._lblDescRelEstado_7.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescRelEstado_7, "")
        '
        '_lblTelCelular_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTelCelular_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTelCelular_9, False)
        Me._lblTelCelular_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblTelCelular_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblTelCelular_9, "Default")
        Me._lblTelCelular_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTelCelular_9.Location = New System.Drawing.Point(235, 107)
        Me._lblTelCelular_9.Name = "_lblTelCelular_9"
        Me._lblTelCelular_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTelCelular_9.Size = New System.Drawing.Size(137, 20)
        Me._lblTelCelular_9.TabIndex = 31
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTelCelular_9, "")
        '
        '_lblDescCategoria_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescCategoria_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescCategoria_6, False)
        Me._lblDescCategoria_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescCategoria_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescCategoria_6, "Default")
        Me._lblDescCategoria_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescCategoria_6.Location = New System.Drawing.Point(235, 41)
        Me._lblDescCategoria_6.Name = "_lblDescCategoria_6"
        Me._lblDescCategoria_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescCategoria_6.Size = New System.Drawing.Size(305, 20)
        Me._lblDescCategoria_6.TabIndex = 30
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescCategoria_6, "")
        '
        '_lblDescProdBanc_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescProdBanc_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescProdBanc_5, False)
        Me._lblDescProdBanc_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescProdBanc_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescProdBanc_5, "Default")
        Me._lblDescProdBanc_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescProdBanc_5.Location = New System.Drawing.Point(235, 19)
        Me._lblDescProdBanc_5.Name = "_lblDescProdBanc_5"
        Me._lblDescProdBanc_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescProdBanc_5.Size = New System.Drawing.Size(305, 20)
        Me._lblDescProdBanc_5.TabIndex = 29
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescProdBanc_5, "")
        '
        '_lblTitulo_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_9, False)
        Me._lblTitulo_9.AutoSize = True
        Me._lblTitulo_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_9, "Default")
        Me._lblTitulo_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_9.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_9.Location = New System.Drawing.Point(10, 173)
        Me._lblTitulo_9.Name = "_lblTitulo_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_9, "2207")
        Me._lblTitulo_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_9.Size = New System.Drawing.Size(92, 13)
        Me._lblTitulo_9.TabIndex = 27
        Me._lblTitulo_9.Text = "*Estado Relación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_9, "")
        '
        '_lblRelEstado_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblRelEstado_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblRelEstado_3, False)
        Me._lblRelEstado_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblRelEstado_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblRelEstado_3, "Default")
        Me._lblRelEstado_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblRelEstado_3.Location = New System.Drawing.Point(183, 173)
        Me._lblRelEstado_3.Name = "_lblRelEstado_3"
        Me._lblRelEstado_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblRelEstado_3.Size = New System.Drawing.Size(50, 20)
        Me._lblRelEstado_3.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblRelEstado_3, "")
        '
        '_lblTitulo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_1, False)
        Me._lblTitulo_1.AutoSize = True
        Me._lblTitulo_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_1, "Default")
        Me._lblTitulo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_1.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_1.Location = New System.Drawing.Point(10, 151)
        Me._lblTitulo_1.Name = "_lblTitulo_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_1, "2202")
        Me._lblTitulo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_1.Size = New System.Drawing.Size(145, 13)
        Me._lblTitulo_1.TabIndex = 26
        Me._lblTitulo_1.Text = "*Confirm. Nro. Tarjeta Debito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_1, "")
        '
        '_lblTitulo_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_8, False)
        Me._lblTitulo_8.AutoSize = True
        Me._lblTitulo_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_8, "Default")
        Me._lblTitulo_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_8.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_8.Location = New System.Drawing.Point(10, 19)
        Me._lblTitulo_8.Name = "_lblTitulo_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_8, "5176")
        Me._lblTitulo_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_8.Size = New System.Drawing.Size(102, 13)
        Me._lblTitulo_8.TabIndex = 25
        Me._lblTitulo_8.Text = "*Producto Bancario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_8, "")
        '
        '_lblTitulo_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_7, False)
        Me._lblTitulo_7.AutoSize = True
        Me._lblTitulo_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_7, "Default")
        Me._lblTitulo_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_7.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_7.Location = New System.Drawing.Point(10, 41)
        Me._lblTitulo_7.Name = "_lblTitulo_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_7, "500786")
        Me._lblTitulo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_7.Size = New System.Drawing.Size(61, 13)
        Me._lblTitulo_7.TabIndex = 24
        Me._lblTitulo_7.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_7, "")
        '
        '_lblTitulo_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_5, False)
        Me._lblTitulo_5.AutoSize = True
        Me._lblTitulo_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_5, "Default")
        Me._lblTitulo_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_5.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_5.Location = New System.Drawing.Point(10, 107)
        Me._lblTitulo_5.Name = "_lblTitulo_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_5, "2205")
        Me._lblTitulo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_5.Size = New System.Drawing.Size(91, 13)
        Me._lblTitulo_5.TabIndex = 23
        Me._lblTitulo_5.Text = "*Teléfono Celular:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_5, "")
        '
        '_lblProdBanc_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblProdBanc_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblProdBanc_2, False)
        Me._lblProdBanc_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblProdBanc_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblProdBanc_2, "Default")
        Me._lblProdBanc_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblProdBanc_2.Location = New System.Drawing.Point(183, 19)
        Me._lblProdBanc_2.Name = "_lblProdBanc_2"
        Me._lblProdBanc_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblProdBanc_2.Size = New System.Drawing.Size(50, 20)
        Me._lblProdBanc_2.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblProdBanc_2, "")
        '
        '_lblCategoria_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblCategoria_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblCategoria_1, False)
        Me._lblCategoria_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblCategoria_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblCategoria_1, "Default")
        Me._lblCategoria_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblCategoria_1.Location = New System.Drawing.Point(183, 41)
        Me._lblCategoria_1.Name = "_lblCategoria_1"
        Me._lblCategoria_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblCategoria_1.Size = New System.Drawing.Size(50, 20)
        Me._lblCategoria_1.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblCategoria_1, "")
        '
        '_lblTitulo_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_2, False)
        Me._lblTitulo_2.AutoSize = True
        Me._lblTitulo_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_2, "Default")
        Me._lblTitulo_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_2.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_2.Location = New System.Drawing.Point(10, 129)
        Me._lblTitulo_2.Name = "_lblTitulo_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_2, "2206")
        Me._lblTitulo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_2.Size = New System.Drawing.Size(104, 13)
        Me._lblTitulo_2.TabIndex = 22
        Me._lblTitulo_2.Text = "*Nro. Tarjeta Débito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_2, "")
        '
        'cmdResetClave
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdResetClave, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdResetClave, False)
        Me.cmdResetClave.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdResetClave, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdResetClave, True)
        Me.cmdResetClave.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdResetClave, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdResetClave, Nothing)
        Me.cmdResetClave.Enabled = False
        Me.cmdResetClave.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdResetClave.Location = New System.Drawing.Point(392, 100)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdResetClave, System.Drawing.Color.Silver)
        Me.cmdResetClave.Name = "cmdResetClave"
        Me.COBISResourceProvider.SetResourceID(Me.cmdResetClave, "2208")
        Me.cmdResetClave.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdResetClave.Size = New System.Drawing.Size(99, 41)
        Me.commandButtonHelper1.SetStyle(Me.cmdResetClave, 0)
        Me.cmdResetClave.TabIndex = 36
        Me.cmdResetClave.Text = "*&Generar Clave"
        Me.cmdResetClave.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdResetClave.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdResetClave, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 384)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 12
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 231)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 9
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "745"
        Me._cmdBoton_1.Text = "*&Actualizar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 180)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 8
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Crear"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me.COBISStyleProvider.SetControlStyle(Me.grdPropietarios, "Default")
        Me.grdPropietarios.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(8, 19)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(532, 58)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 17
        Me.grdPropietarios.TabStop = False
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 10)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 7
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Buscar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(146, 37)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(169, 20)
        Me.mskCuenta.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 333)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 11
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
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-100, 281)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 10
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*&Eliminar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        '_lblProducto_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblProducto_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblProducto_10, False)
        Me._lblProducto_10.AutoSize = True
        Me._lblProducto_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblProducto_10, "Default")
        Me._lblProducto_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblProducto_10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblProducto_10.ForeColor = System.Drawing.Color.Navy
        Me._lblProducto_10.Location = New System.Drawing.Point(10, 10)
        Me._lblProducto_10.Name = "_lblProducto_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblProducto_10, "5048")
        Me._lblProducto_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblProducto_10.Size = New System.Drawing.Size(57, 13)
        Me._lblProducto_10.TabIndex = 32
        Me._lblProducto_10.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblProducto_10, "")
        '
        '_lblNomCuenta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblNomCuenta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblNomCuenta_6, False)
        Me._lblNomCuenta_6.AutoSize = True
        Me._lblNomCuenta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblNomCuenta_6, "Default")
        Me._lblNomCuenta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblNomCuenta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblNomCuenta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblNomCuenta_6.Location = New System.Drawing.Point(10, 61)
        Me._lblNomCuenta_6.Name = "_lblNomCuenta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblNomCuenta_6, "500108")
        Me._lblNomCuenta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblNomCuenta_6.Size = New System.Drawing.Size(113, 13)
        Me._lblNomCuenta_6.TabIndex = 19
        Me._lblNomCuenta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblNomCuenta_6, "")
        '
        '_lblCuenta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblCuenta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblCuenta_0, False)
        Me._lblCuenta_0.AutoSize = True
        Me._lblCuenta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblCuenta_0, "Default")
        Me._lblCuenta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblCuenta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblCuenta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblCuenta_0.Location = New System.Drawing.Point(10, 37)
        Me._lblCuenta_0.Name = "_lblCuenta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblCuenta_0, "2400")
        Me._lblCuenta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblCuenta_0.Size = New System.Drawing.Size(82, 13)
        Me._lblCuenta_0.TabIndex = 18
        Me._lblCuenta_0.Text = "*No. de cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblCuenta_0, "")
        '
        '_lblCuentaDesc_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblCuentaDesc_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblCuentaDesc_0, False)
        Me._lblCuentaDesc_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblCuentaDesc_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblCuentaDesc_0, "Default")
        Me._lblCuentaDesc_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblCuentaDesc_0.Location = New System.Drawing.Point(146, 61)
        Me._lblCuentaDesc_0.Name = "_lblCuentaDesc_0"
        Me._lblCuentaDesc_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblCuentaDesc_0.Size = New System.Drawing.Size(411, 20)
        Me._lblCuentaDesc_0.TabIndex = 13
        Me._lblCuentaDesc_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblCuentaDesc_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblProducto_10)
        Me.PFormas.Controls.Add(Me.cmbProducto)
        Me.PFormas.Controls.Add(Me._lblCuentaDesc_0)
        Me.PFormas.Controls.Add(Me.frmDatosCanales)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._lblCuenta_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblNomCuenta_6)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(562, 463)
        Me.PFormas.TabIndex = 36
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 91)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "5055")
        Me.GroupBox1.Size = New System.Drawing.Size(547, 83)
        Me.GroupBox1.TabIndex = 34
        Me.GroupBox1.Text = "*Propietarios"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TBSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TBSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TBSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TBSBotones, "Default")
        Me.TBSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir, Me.TSBGenerar})
        Me.TBSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TBSBotones.Name = "TBSBotones"
        Me.TBSBotones.Size = New System.Drawing.Size(584, 25)
        Me.TBSBotones.TabIndex = 37
        Me.TBSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TBSBotones, "")
        '
        'TSBBuscar
        '
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
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2007")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2002")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2023")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBLimpiar
        '
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
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'TSBGenerar
        '
        Me.TSBGenerar.Image = CType(resources.GetObject("TSBGenerar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBGenerar, "2060")
        Me.TSBGenerar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBGenerar.Name = "TSBGenerar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBGenerar, "2208")
        Me.TSBGenerar.Size = New System.Drawing.Size(105, 22)
        Me.TSBGenerar.Text = "*&Generar Clave"
        '
        'FRelCtaCanalClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TBSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(3, 29)
        Me.Name = "FRelCtaCanalClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(584, 502)
        Me.Tag = "743"
        Me.Text = "Relación Cuenta a Canales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmDatosCanales, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmDatosCanales.ResumeLayout(False)
        Me.frmDatosCanales.PerformLayout()
        CType(Me.grdRelacionCanal, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TBSBotones.ResumeLayout(False)
        Me.TBSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializelblTitulo()
        Me.lblTitulo(9) = _lblTitulo_9
        Me.lblTitulo(1) = _lblTitulo_1
        Me.lblTitulo(8) = _lblTitulo_8
        Me.lblTitulo(7) = _lblTitulo_7
        Me.lblTitulo(5) = _lblTitulo_5
        Me.lblTitulo(2) = _lblTitulo_2
    End Sub
    Sub InitializelblTelCelular()
        Me.lblTelCelular(9) = _lblTelCelular_9
    End Sub
    Sub InitializelblRelEstado()
        Me.lblRelEstado(3) = _lblRelEstado_3
    End Sub

    Sub InitializelblProducto()
        Me.lblProducto(10) = _lblProducto_10
    End Sub
    Sub InitializelblProdBanc()
        Me.lblProdBanc(2) = _lblProdBanc_2
    End Sub
    Sub InitializelblNomCuenta()
        Me.lblNomCuenta(6) = _lblNomCuenta_6
    End Sub
    Sub InitializelblDescRelEstado()
        Me.lblDescRelEstado(7) = _lblDescRelEstado_7
    End Sub
    Sub InitializelblDescProdBanc()
        Me.lblDescProdBanc(5) = _lblDescProdBanc_5
    End Sub
    Sub InitializelblDescCategoria()
        Me.lblDescCategoria(6) = _lblDescCategoria_6
    End Sub
    Sub InitializelblDescCanal()
        Me.lblDescCanal(0) = _lblDescCanal_0
    End Sub
    Sub InitializelblCuentaDesc()
        Me.lblCuentaDesc(0) = _lblCuentaDesc_0
    End Sub
    Sub InitializelblCuenta()
        Me.lblCuenta(0) = _lblCuenta_0
    End Sub
    Sub InitializelblCategoria()
        Me.lblCategoria(1) = _lblCategoria_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(5) = _cmdBoton_5
    End Sub

    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TBSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBGenerar As System.Windows.Forms.ToolStripButton
#End Region
End Class


