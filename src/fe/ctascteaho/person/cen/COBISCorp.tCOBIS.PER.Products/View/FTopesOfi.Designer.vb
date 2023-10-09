Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTopesOfiClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializemskMonto()
		InitializelblEtiqueta()
		InitializelblDescripcionOo()
		InitializelblDescripcion()
		InitializegrdVariables2()
		InitializecmdBoton()
        InitializeFrame3()
		InitializeFrame2()
		MhTListaLimitesPreviousTab = MhTListaLimites.SelectedIndex
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
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _mskMonto_1 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _mskMonto_2 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _Frame2_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _mskMonto_3 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _mskMonto_4 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _lblDescripcionOo_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcionOo_1 As System.Windows.Forms.Label
    Private WithEvents _Frame3_1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents TextValid As System.Windows.Forms.TextBox
    Private WithEvents _MhTListaLimites_TabPage0 As System.Windows.Forms.TabPage
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents FrmLImD As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents BtnEliminarLim As System.Windows.Forms.Button
    Public WithEvents BtnBuscarLim As System.Windows.Forms.Button
    Public WithEvents BtnAgregarLim As System.Windows.Forms.Button
    Public WithEvents grdLimites As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents lblEspecie As System.Windows.Forms.Label
    Public WithEvents lblOrigen As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _Frame2_1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _MhTListaLimites_TabPage1 As System.Windows.Forms.TabPage
    Private WithEvents _grdVariables2_0 As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _MhTListaLimites_TabPage2 As System.Windows.Forms.TabPage
    Public WithEvents MhTListaLimites As COBISCorp.Framework.UI.Components.COBISTabControl
    Public WithEvents cmbTipo As System.Windows.Forms.ComboBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdVariables As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
	Public Frame2(1) As Infragistics.Win.Misc.UltraGroupBox
	Public Frame3(1) As Infragistics.Win.Misc.UltraGroupBox
	Public Line1(0) As System.Windows.Forms.Label
	Public cmdBoton(5) As System.Windows.Forms.Button
	Public grdVariables2(0) As COBISCorp.Framework.UI.Components.COBISGrid
	Public lblDescripcion(2) As System.Windows.Forms.Label
	Public lblDescripcionOo(2) As System.Windows.Forms.Label
	Public lblEtiqueta(10) As System.Windows.Forms.Label
	Public mskMonto(4) As COBISCorp.Framework.UI.Components.CobisRealInput
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	Dim Private MhTListaLimitesPreviousTab As Integer = 0
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTopesOfiClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.MhTListaLimites = New COBISCorp.Framework.UI.Components.COBISTabControl()
        Me._MhTListaLimites_TabPage0 = New System.Windows.Forms.TabPage()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.TextValid = New System.Windows.Forms.TextBox()
        Me._Frame2_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Check1 = New System.Windows.Forms.CheckBox()
        Me.Check2 = New System.Windows.Forms.CheckBox()
        Me._mskMonto_1 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._mskMonto_2 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._Frame3_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Check4 = New System.Windows.Forms.CheckBox()
        Me.Check3 = New System.Windows.Forms.CheckBox()
        Me._mskMonto_3 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._mskMonto_4 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lblDescripcionOo_2 = New System.Windows.Forms.Label()
        Me._lblDescripcionOo_1 = New System.Windows.Forms.Label()
        Me._MhTListaLimites_TabPage1 = New System.Windows.Forms.TabPage()
        Me._Frame2_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TextEspecie = New System.Windows.Forms.TextBox()
        Me.txtOrigen = New System.Windows.Forms.TextBox()
        Me.FrmLImD = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskNumTx = New System.Windows.Forms.TextBox()
        Me.mskMontoRetiro = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.BtnEliminarLim = New System.Windows.Forms.Button()
        Me.BtnBuscarLim = New System.Windows.Forms.Button()
        Me.BtnAgregarLim = New System.Windows.Forms.Button()
        Me.grdLimites = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.lblEspecie = New System.Windows.Forms.Label()
        Me.lblOrigen = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._MhTListaLimites_TabPage2 = New System.Windows.Forms.TabPage()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TextCausal = New System.Windows.Forms.TextBox()
        Me.FrmOE = New Infragistics.Win.Misc.UltraGroupBox()
        Me.LblEspecie22 = New System.Windows.Forms.Label()
        Me.LblOrigen22 = New System.Windows.Forms.Label()
        Me.LblEspecie2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me.LblOrigen2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me.BtnBuscarCau = New System.Windows.Forms.Button()
        Me.BtnEliminarCau = New System.Windows.Forms.Button()
        Me.BtnAgregarCau = New System.Windows.Forms.Button()
        Me.grdCausales = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me.lblCausal = New System.Windows.Forms.Label()
        Me._grdVariables2_0 = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.cmbTipo = New System.Windows.Forms.ComboBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdVariables = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.MhTListaLimites.SuspendLayout()
        Me._MhTListaLimites_TabPage0.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me._Frame2_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_0.SuspendLayout()
        CType(Me._Frame3_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame3_1.SuspendLayout()
        Me._MhTListaLimites_TabPage1.SuspendLayout()
        CType(Me._Frame2_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame2_1.SuspendLayout()
        CType(Me.FrmLImD, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmLImD.SuspendLayout()
        CType(Me.grdLimites, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._MhTListaLimites_TabPage2.SuspendLayout()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me.FrmOE, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmOE.SuspendLayout()
        CType(Me.grdCausales, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._grdVariables2_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdVariables, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'MhTListaLimites
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.MhTListaLimites, False)
        Me.COBISViewResizer.SetAutoResize(Me.MhTListaLimites, False)
        Me.MhTListaLimites.Controls.Add(Me._MhTListaLimites_TabPage0)
        Me.MhTListaLimites.Controls.Add(Me._MhTListaLimites_TabPage1)
        Me.MhTListaLimites.Controls.Add(Me._MhTListaLimites_TabPage2)
        Me.COBISStyleProvider.SetControlStyle(Me.MhTListaLimites, "Default")
        Me.MhTListaLimites.DrawMode = System.Windows.Forms.TabDrawMode.OwnerDrawFixed
        Me.MhTListaLimites.Location = New System.Drawing.Point(10, 42)
        Me.MhTListaLimites.Multiline = True
        Me.MhTListaLimites.Name = "MhTListaLimites"
        Me.MhTListaLimites.SelectedIndex = 0
        Me.MhTListaLimites.Size = New System.Drawing.Size(564, 317)
        Me.MhTListaLimites.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.MhTListaLimites, "")
        '
        '_MhTListaLimites_TabPage0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhTListaLimites_TabPage0, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhTListaLimites_TabPage0, False)
        Me._MhTListaLimites_TabPage0.BackColor = System.Drawing.Color.Transparent
        Me._MhTListaLimites_TabPage0.Controls.Add(Me.UltraGroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me._MhTListaLimites_TabPage0, "Default")
        Me._MhTListaLimites_TabPage0.Location = New System.Drawing.Point(4, 22)
        Me._MhTListaLimites_TabPage0.Name = "_MhTListaLimites_TabPage0"
        Me._MhTListaLimites_TabPage0.Size = New System.Drawing.Size(556, 291)
        Me._MhTListaLimites_TabPage0.TabIndex = 0
        Me._MhTListaLimites_TabPage0.Text = "Límites de Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhTListaLimites_TabPage0, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me.TextValid)
        Me.UltraGroupBox1.Controls.Add(Me._Frame2_0)
        Me.UltraGroupBox1.Controls.Add(Me._Frame3_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.UltraGroupBox1.Location = New System.Drawing.Point(0, 0)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(556, 291)
        Me.UltraGroupBox1.TabIndex = 14
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1057")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(171, 13)
        Me._lblEtiqueta_0.TabIndex = 12
        Me._lblEtiqueta_0.Text = "*Cantidad de Transacciones:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'TextValid
        '
        Me.TextValid.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.TextValid, False)
        Me.COBISViewResizer.SetAutoResize(Me.TextValid, False)
        Me.TextValid.BackColor = System.Drawing.SystemColors.Window
        Me.TextValid.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.TextValid, "Default")
        Me.TextValid.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.TextValid.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.TextValid.ForeColor = System.Drawing.SystemColors.WindowText
        Me.TextValid.Location = New System.Drawing.Point(235, 10)
        Me.TextValid.MaxLength = 3
        Me.TextValid.Name = "TextValid"
        Me.TextValid.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.TextValid.Size = New System.Drawing.Size(101, 20)
        Me.TextValid.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TextValid, "")
        '
        '_Frame2_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_0, False)
        Me._Frame2_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_0.Controls.Add(Me.Check1)
        Me._Frame2_0.Controls.Add(Me.Check2)
        Me._Frame2_0.Controls.Add(Me._mskMonto_1)
        Me._Frame2_0.Controls.Add(Me._mskMonto_2)
        Me._Frame2_0.Controls.Add(Me._lblDescripcion_1)
        Me._Frame2_0.Controls.Add(Me._lblDescripcion_2)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_0, "Default")
        Me._Frame2_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame2_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_0.Location = New System.Drawing.Point(10, 42)
        Me._Frame2_0.Name = "_Frame2_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame2_0, "1460")
        Me._Frame2_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame2_0.Size = New System.Drawing.Size(537, 107)
        Me._Frame2_0.TabIndex = 2
        Me._Frame2_0.Text = "*Límites en la Oficina Radicadora"
        Me._Frame2_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_0, "")
        '
        'Check1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Check1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Check1, False)
        Me.Check1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Check1, "Default")
        Me.Check1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Check1.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.Check1.Location = New System.Drawing.Point(10, 40)
        Me.Check1.Name = "Check1"
        Me.COBISResourceProvider.SetResourceID(Me.Check1, "1221")
        Me.Check1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check1.Size = New System.Drawing.Size(105, 17)
        Me.Check1.TabIndex = 2
        Me.Check1.Text = "*Efectivo"
        Me.Check1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Check1, "")
        '
        'Check2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Check2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Check2, False)
        Me.Check2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Check2, "Default")
        Me.Check2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Check2.Location = New System.Drawing.Point(10, 62)
        Me.Check2.Name = "Check2"
        Me.COBISResourceProvider.SetResourceID(Me.Check2, "1079")
        Me.Check2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check2.Size = New System.Drawing.Size(129, 17)
        Me.Check2.TabIndex = 4
        Me.Check2.Text = "*Chq. Gerencia"
        Me.Check2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Check2, "")
        '
        '_mskMonto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskMonto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskMonto_1, False)
        Me._mskMonto_1.BackColor = System.Drawing.SystemColors.Window
        Me._mskMonto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskMonto_1, "Default")
        Me._mskMonto_1.DecimalPlaces = 2
        Me._mskMonto_1.Enabled = False
        Me._mskMonto_1.Location = New System.Drawing.Point(225, 40)
        Me._mskMonto_1.MaxLength = 17
        Me._mskMonto_1.MaxReal = 0.0!
        Me._mskMonto_1.MinReal = 0.0!
        Me._mskMonto_1.Name = "_mskMonto_1"
        Me._mskMonto_1.Separator = True
        Me._mskMonto_1.Size = New System.Drawing.Size(159, 20)
        Me._mskMonto_1.TabIndex = 3
        Me._mskMonto_1.Text = "0.00"
        Me._mskMonto_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskMonto_1.ValueDouble = 0.0R
        Me._mskMonto_1.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskMonto_1, "")
        '
        '_mskMonto_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskMonto_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskMonto_2, False)
        Me._mskMonto_2.BackColor = System.Drawing.SystemColors.Window
        Me._mskMonto_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskMonto_2, "Default")
        Me._mskMonto_2.DecimalPlaces = 2
        Me._mskMonto_2.Enabled = False
        Me._mskMonto_2.Location = New System.Drawing.Point(225, 62)
        Me._mskMonto_2.MaxLength = 17
        Me._mskMonto_2.MaxReal = 0.0!
        Me._mskMonto_2.MinReal = 0.0!
        Me._mskMonto_2.Name = "_mskMonto_2"
        Me._mskMonto_2.Separator = True
        Me._mskMonto_2.Size = New System.Drawing.Size(159, 20)
        Me._mskMonto_2.TabIndex = 5
        Me._mskMonto_2.Text = "0.00"
        Me._mskMonto_2.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskMonto_2.ValueDouble = 0.0R
        Me._mskMonto_2.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskMonto_2, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblDescripcion_1.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcion_1.Location = New System.Drawing.Point(146, 40)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcion_1, "1813")
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(80, 23)
        Me._lblDescripcion_1.TabIndex = 4
        Me._lblDescripcion_1.Text = "*Valor Ref :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblDescripcion_2.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcion_2.Location = New System.Drawing.Point(146, 62)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcion_2, "1813")
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(80, 23)
        Me._lblDescripcion_2.TabIndex = 3
        Me._lblDescripcion_2.Text = "*Valor Ref :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_Frame3_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame3_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame3_1, False)
        Me._Frame3_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame3_1.Controls.Add(Me.Check4)
        Me._Frame3_1.Controls.Add(Me.Check3)
        Me._Frame3_1.Controls.Add(Me._mskMonto_3)
        Me._Frame3_1.Controls.Add(Me._mskMonto_4)
        Me._Frame3_1.Controls.Add(Me._lblDescripcionOo_2)
        Me._Frame3_1.Controls.Add(Me._lblDescripcionOo_1)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame3_1, "Default")
        Me._Frame3_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame3_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame3_1.Location = New System.Drawing.Point(10, 161)
        Me._Frame3_1.Name = "_Frame3_1"
        Me._Frame3_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame3_1.Size = New System.Drawing.Size(537, 115)
        Me._Frame3_1.TabIndex = 5
        Me._Frame3_1.Text = "Límites en otras Oficinas"
        Me._Frame3_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame3_1, "")
        '
        'Check4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Check4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Check4, False)
        Me.Check4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Check4, "Default")
        Me.Check4.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Check4.Location = New System.Drawing.Point(10, 62)
        Me.Check4.Name = "Check4"
        Me.COBISResourceProvider.SetResourceID(Me.Check4, "1079")
        Me.Check4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check4.Size = New System.Drawing.Size(129, 17)
        Me.Check4.TabIndex = 8
        Me.Check4.Text = "*Chq. Gerencia"
        Me.Check4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Check4, "")
        '
        'Check3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Check3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Check3, False)
        Me.Check3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Check3, "Default")
        Me.Check3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Check3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Check3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Check3.Location = New System.Drawing.Point(10, 40)
        Me.Check3.Name = "Check3"
        Me.COBISResourceProvider.SetResourceID(Me.Check3, "1221")
        Me.Check3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Check3.Size = New System.Drawing.Size(105, 17)
        Me.Check3.TabIndex = 6
        Me.Check3.Text = "*Efectivo"
        Me.Check3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Check3, "")
        '
        '_mskMonto_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskMonto_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskMonto_3, False)
        Me._mskMonto_3.BackColor = System.Drawing.SystemColors.Window
        Me._mskMonto_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskMonto_3, "Default")
        Me._mskMonto_3.DecimalPlaces = 2
        Me._mskMonto_3.Enabled = False
        Me._mskMonto_3.Location = New System.Drawing.Point(225, 40)
        Me._mskMonto_3.MaxLength = 17
        Me._mskMonto_3.MaxReal = 0.0!
        Me._mskMonto_3.MinReal = 0.0!
        Me._mskMonto_3.Name = "_mskMonto_3"
        Me._mskMonto_3.Separator = True
        Me._mskMonto_3.Size = New System.Drawing.Size(159, 20)
        Me._mskMonto_3.TabIndex = 7
        Me._mskMonto_3.Text = "0.00"
        Me._mskMonto_3.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskMonto_3.ValueDouble = 0.0R
        Me._mskMonto_3.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskMonto_3, "")
        '
        '_mskMonto_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskMonto_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskMonto_4, False)
        Me._mskMonto_4.BackColor = System.Drawing.SystemColors.Window
        Me._mskMonto_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskMonto_4, "Default")
        Me._mskMonto_4.DecimalPlaces = 2
        Me._mskMonto_4.Enabled = False
        Me._mskMonto_4.Location = New System.Drawing.Point(225, 62)
        Me._mskMonto_4.MaxLength = 17
        Me._mskMonto_4.MaxReal = 0.0!
        Me._mskMonto_4.MinReal = 0.0!
        Me._mskMonto_4.Name = "_mskMonto_4"
        Me._mskMonto_4.Separator = True
        Me._mskMonto_4.Size = New System.Drawing.Size(159, 20)
        Me._mskMonto_4.TabIndex = 9
        Me._mskMonto_4.Text = "0.00"
        Me._mskMonto_4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskMonto_4.ValueDouble = 0.0R
        Me._mskMonto_4.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskMonto_4, "")
        '
        '_lblDescripcionOo_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcionOo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcionOo_2, False)
        Me._lblDescripcionOo_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcionOo_2, "Default")
        Me._lblDescripcionOo_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcionOo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblDescripcionOo_2.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcionOo_2.Location = New System.Drawing.Point(146, 62)
        Me._lblDescripcionOo_2.Name = "_lblDescripcionOo_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcionOo_2, "1813")
        Me._lblDescripcionOo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcionOo_2.Size = New System.Drawing.Size(80, 23)
        Me._lblDescripcionOo_2.TabIndex = 7
        Me._lblDescripcionOo_2.Text = "*Valor Ref :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcionOo_2, "")
        '
        '_lblDescripcionOo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcionOo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcionOo_1, False)
        Me._lblDescripcionOo_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcionOo_1, "Default")
        Me._lblDescripcionOo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcionOo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblDescripcionOo_1.ForeColor = System.Drawing.Color.Navy
        Me._lblDescripcionOo_1.Location = New System.Drawing.Point(146, 40)
        Me._lblDescripcionOo_1.Name = "_lblDescripcionOo_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblDescripcionOo_1, "1813")
        Me._lblDescripcionOo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcionOo_1.Size = New System.Drawing.Size(80, 23)
        Me._lblDescripcionOo_1.TabIndex = 6
        Me._lblDescripcionOo_1.Text = "*Valor Ref :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcionOo_1, "")
        '
        '_MhTListaLimites_TabPage1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhTListaLimites_TabPage1, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhTListaLimites_TabPage1, False)
        Me._MhTListaLimites_TabPage1.BackColor = System.Drawing.Color.Transparent
        Me._MhTListaLimites_TabPage1.Controls.Add(Me._Frame2_1)
        Me.COBISStyleProvider.SetControlStyle(Me._MhTListaLimites_TabPage1, "Default")
        Me._MhTListaLimites_TabPage1.Location = New System.Drawing.Point(4, 22)
        Me._MhTListaLimites_TabPage1.Name = "_MhTListaLimites_TabPage1"
        Me._MhTListaLimites_TabPage1.Size = New System.Drawing.Size(556, 291)
        Me._MhTListaLimites_TabPage1.TabIndex = 1
        Me._MhTListaLimites_TabPage1.Text = "Límites Origen-Especie"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhTListaLimites_TabPage1, "")
        '
        '_Frame2_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame2_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame2_1, False)
        Me._Frame2_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame2_1.Controls.Add(Me.TextEspecie)
        Me._Frame2_1.Controls.Add(Me.txtOrigen)
        Me._Frame2_1.Controls.Add(Me.FrmLImD)
        Me._Frame2_1.Controls.Add(Me.BtnEliminarLim)
        Me._Frame2_1.Controls.Add(Me.BtnBuscarLim)
        Me._Frame2_1.Controls.Add(Me.BtnAgregarLim)
        Me._Frame2_1.Controls.Add(Me.grdLimites)
        Me._Frame2_1.Controls.Add(Me.lblEspecie)
        Me._Frame2_1.Controls.Add(Me.lblOrigen)
        Me._Frame2_1.Controls.Add(Me._lblEtiqueta_4)
        Me._Frame2_1.Controls.Add(Me._lblEtiqueta_3)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame2_1, "Default")
        Me._Frame2_1.Dock = System.Windows.Forms.DockStyle.Fill
        Me._Frame2_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame2_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame2_1.Location = New System.Drawing.Point(0, 0)
        Me._Frame2_1.Name = "_Frame2_1"
        Me._Frame2_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame2_1.Size = New System.Drawing.Size(556, 291)
        Me._Frame2_1.TabIndex = 15
        Me._Frame2_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame2_1, "")
        '
        'TextEspecie
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TextEspecie, False)
        Me.COBISViewResizer.SetAutoResize(Me.TextEspecie, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TextEspecie, "Default")
        Me.TextEspecie.Location = New System.Drawing.Point(79, 32)
        Me.TextEspecie.MaxLength = 3
        Me.TextEspecie.Name = "TextEspecie"
        Me.TextEspecie.Size = New System.Drawing.Size(98, 20)
        Me.TextEspecie.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TextEspecie, "")
        '
        'txtOrigen
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtOrigen, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtOrigen, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtOrigen, "Default")
        Me.txtOrigen.Location = New System.Drawing.Point(79, 10)
        Me.txtOrigen.MaxLength = 3
        Me.txtOrigen.Name = "txtOrigen"
        Me.txtOrigen.Size = New System.Drawing.Size(98, 20)
        Me.txtOrigen.TabIndex = 10
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtOrigen, "")
        '
        'FrmLImD
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmLImD, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmLImD, False)
        Me.FrmLImD.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmLImD.Controls.Add(Me.mskNumTx)
        Me.FrmLImD.Controls.Add(Me.mskMontoRetiro)
        Me.FrmLImD.Controls.Add(Me._lblEtiqueta_5)
        Me.FrmLImD.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmLImD, "Default")
        Me.FrmLImD.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrmLImD.ForeColor = System.Drawing.Color.Navy
        Me.FrmLImD.Location = New System.Drawing.Point(10, 55)
        Me.FrmLImD.Name = "FrmLImD"
        Me.COBISResourceProvider.SetResourceID(Me.FrmLImD, "1457")
        Me.FrmLImD.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmLImD.Size = New System.Drawing.Size(528, 65)
        Me.FrmLImD.TabIndex = 12
        Me.FrmLImD.Text = "*Límites Diarios"
        Me.FrmLImD.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmLImD, "")
        '
        'mskNumTx
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskNumTx, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskNumTx, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskNumTx, "Default")
        Me.mskNumTx.Location = New System.Drawing.Point(170, 16)
        Me.mskNumTx.MaxLength = 3
        Me.mskNumTx.Name = "mskNumTx"
        Me.mskNumTx.Size = New System.Drawing.Size(100, 20)
        Me.mskNumTx.TabIndex = 12
        Me.mskNumTx.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskNumTx, "")
        '
        'mskMontoRetiro
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskMontoRetiro, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskMontoRetiro, False)
        Me.mskMontoRetiro.BackColor = System.Drawing.SystemColors.Window
        Me.mskMontoRetiro.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskMontoRetiro, "Default")
        Me.mskMontoRetiro.DecimalPlaces = 2
        Me.mskMontoRetiro.Location = New System.Drawing.Point(170, 41)
        Me.mskMontoRetiro.MaxLength = 17
        Me.mskMontoRetiro.MaxReal = 0.0!
        Me.mskMontoRetiro.MinReal = 0.0!
        Me.mskMontoRetiro.Name = "mskMontoRetiro"
        Me.mskMontoRetiro.Separator = True
        Me.mskMontoRetiro.Size = New System.Drawing.Size(159, 20)
        Me.mskMontoRetiro.TabIndex = 13
        Me.mskMontoRetiro.Text = "0.00"
        Me.mskMontoRetiro.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskMontoRetiro.ValueDouble = 0.0R
        Me.mskMontoRetiro.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskMontoRetiro, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.AutoSize = True
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(3, 19)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "1526")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(164, 13)
        Me._lblEtiqueta_5.TabIndex = 59
        Me._lblEtiqueta_5.Text = "*Número de Transacciones:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(3, 43)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "1488")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(113, 13)
        Me._lblEtiqueta_6.TabIndex = 58
        Me._lblEtiqueta_6.Text = "*Monto en Retiros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'BtnEliminarLim
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnEliminarLim, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnEliminarLim, False)
        Me.BtnEliminarLim.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnEliminarLim, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnEliminarLim, True)
        Me.BtnEliminarLim.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnEliminarLim, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnEliminarLim, Nothing)
        Me.BtnEliminarLim.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnEliminarLim.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnEliminarLim.Location = New System.Drawing.Point(471, 214)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnEliminarLim, System.Drawing.Color.Silver)
        Me.BtnEliminarLim.Name = "BtnEliminarLim"
        Me.COBISResourceProvider.SetResourceID(Me.BtnEliminarLim, "1312")
        Me.BtnEliminarLim.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnEliminarLim.Size = New System.Drawing.Size(67, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnEliminarLim, 0)
        Me.BtnEliminarLim.TabIndex = 17
        Me.BtnEliminarLim.Tag = "735"
        Me.BtnEliminarLim.Text = "*Eliminar"
        Me.BtnEliminarLim.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnEliminarLim.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnEliminarLim, "")
        '
        'BtnBuscarLim
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnBuscarLim, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnBuscarLim, False)
        Me.BtnBuscarLim.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnBuscarLim, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnBuscarLim, True)
        Me.BtnBuscarLim.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnBuscarLim, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnBuscarLim, Nothing)
        Me.BtnBuscarLim.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnBuscarLim.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnBuscarLim.Location = New System.Drawing.Point(471, 158)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnBuscarLim, System.Drawing.Color.Silver)
        Me.BtnBuscarLim.Name = "BtnBuscarLim"
        Me.COBISResourceProvider.SetResourceID(Me.BtnBuscarLim, "1027")
        Me.BtnBuscarLim.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnBuscarLim.Size = New System.Drawing.Size(67, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnBuscarLim, 0)
        Me.BtnBuscarLim.TabIndex = 15
        Me.BtnBuscarLim.Text = "*Buscar"
        Me.BtnBuscarLim.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnBuscarLim.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnBuscarLim, "")
        '
        'BtnAgregarLim
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnAgregarLim, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnAgregarLim, False)
        Me.BtnAgregarLim.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnAgregarLim, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnAgregarLim, True)
        Me.BtnAgregarLim.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnAgregarLim, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnAgregarLim, Nothing)
        Me.BtnAgregarLim.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnAgregarLim.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnAgregarLim.Location = New System.Drawing.Point(471, 186)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnAgregarLim, System.Drawing.Color.Silver)
        Me.BtnAgregarLim.Name = "BtnAgregarLim"
        Me.COBISResourceProvider.SetResourceID(Me.BtnAgregarLim, "1016")
        Me.BtnAgregarLim.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnAgregarLim.Size = New System.Drawing.Size(67, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnAgregarLim, 0)
        Me.BtnAgregarLim.TabIndex = 16
        Me.BtnAgregarLim.Tag = "735"
        Me.BtnAgregarLim.Text = "*Agregar"
        Me.BtnAgregarLim.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnAgregarLim.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnAgregarLim, "")
        '
        'grdLimites
        '
        Me.grdLimites._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdLimites, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdLimites, False)
        Me.grdLimites.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdLimites.Clip = ""
        Me.grdLimites.Col = CType(1, Short)
        Me.grdLimites.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdLimites.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdLimites.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdLimites, "Default")
        Me.grdLimites.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdLimites, True)
        Me.grdLimites.FixedCols = CType(1, Short)
        Me.grdLimites.FixedRows = CType(1, Short)
        Me.grdLimites.ForeColor = System.Drawing.Color.Black
        Me.grdLimites.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdLimites.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdLimites.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdLimites.HighLight = True
        Me.grdLimites.Location = New System.Drawing.Point(10, 128)
        Me.grdLimites.Name = "grdLimites"
        Me.grdLimites.Picture = Nothing
        Me.grdLimites.Row = CType(1, Short)
        Me.grdLimites.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdLimites.Size = New System.Drawing.Size(457, 149)
        Me.grdLimites.Sort = CType(2, Short)
        Me.grdLimites.TabIndex = 14
        Me.grdLimites.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdLimites, "")
        '
        'lblEspecie
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEspecie, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEspecie, False)
        Me.lblEspecie.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblEspecie.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblEspecie, "Default")
        Me.lblEspecie.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEspecie.Enabled = False
        Me.lblEspecie.Location = New System.Drawing.Point(180, 32)
        Me.lblEspecie.Name = "lblEspecie"
        Me.lblEspecie.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEspecie.Size = New System.Drawing.Size(358, 20)
        Me.lblEspecie.TabIndex = 34
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEspecie, "")
        '
        'lblOrigen
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblOrigen, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblOrigen, False)
        Me.lblOrigen.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblOrigen.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblOrigen, "Default")
        Me.lblOrigen.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblOrigen.Enabled = False
        Me.lblOrigen.Location = New System.Drawing.Point(180, 10)
        Me.lblOrigen.Name = "lblOrigen"
        Me.lblOrigen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblOrigen.Size = New System.Drawing.Size(358, 20)
        Me.lblOrigen.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblOrigen, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.AutoSize = True
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(12, 35)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "1330")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(61, 13)
        Me._lblEtiqueta_4.TabIndex = 20
        Me._lblEtiqueta_4.Text = "*Especie:"
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
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(12, 13)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "1618")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(53, 13)
        Me._lblEtiqueta_3.TabIndex = 18
        Me._lblEtiqueta_3.Text = "*Origen:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_MhTListaLimites_TabPage2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MhTListaLimites_TabPage2, False)
        Me.COBISViewResizer.SetAutoResize(Me._MhTListaLimites_TabPage2, False)
        Me._MhTListaLimites_TabPage2.BackColor = System.Drawing.Color.Transparent
        Me._MhTListaLimites_TabPage2.Controls.Add(Me.Frame1)
        Me.COBISStyleProvider.SetControlStyle(Me._MhTListaLimites_TabPage2, "Default")
        Me._MhTListaLimites_TabPage2.Location = New System.Drawing.Point(4, 22)
        Me._MhTListaLimites_TabPage2.Name = "_MhTListaLimites_TabPage2"
        Me._MhTListaLimites_TabPage2.Size = New System.Drawing.Size(556, 291)
        Me._MhTListaLimites_TabPage2.TabIndex = 2
        Me._MhTListaLimites_TabPage2.Text = "Causales Origen- Especie"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MhTListaLimites_TabPage2, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me.TextCausal)
        Me.Frame1.Controls.Add(Me.FrmOE)
        Me.Frame1.Controls.Add(Me.BtnBuscarCau)
        Me.Frame1.Controls.Add(Me.BtnEliminarCau)
        Me.Frame1.Controls.Add(Me.BtnAgregarCau)
        Me.Frame1.Controls.Add(Me.grdCausales)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_8)
        Me.Frame1.Controls.Add(Me.lblCausal)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Frame1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(0, 0)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(556, 291)
        Me.Frame1.TabIndex = 35
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        'TextCausal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TextCausal, False)
        Me.COBISViewResizer.SetAutoResize(Me.TextCausal, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TextCausal, "Default")
        Me.TextCausal.Location = New System.Drawing.Point(85, 25)
        Me.TextCausal.MaxLength = 3
        Me.TextCausal.Name = "TextCausal"
        Me.TextCausal.Size = New System.Drawing.Size(65, 20)
        Me.TextCausal.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TextCausal, "")
        '
        'FrmOE
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmOE, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmOE, False)
        Me.FrmOE.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmOE.Controls.Add(Me.LblEspecie22)
        Me.FrmOE.Controls.Add(Me.LblOrigen22)
        Me.FrmOE.Controls.Add(Me.LblEspecie2)
        Me.FrmOE.Controls.Add(Me._lblEtiqueta_10)
        Me.FrmOE.Controls.Add(Me.LblOrigen2)
        Me.FrmOE.Controls.Add(Me._lblEtiqueta_9)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmOE, "Default")
        Me.FrmOE.Enabled = False
        Me.FrmOE.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrmOE.ForeColor = System.Drawing.Color.Navy
        Me.FrmOE.Location = New System.Drawing.Point(10, 50)
        Me.FrmOE.Name = "FrmOE"
        Me.FrmOE.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmOE.Size = New System.Drawing.Size(533, 62)
        Me.FrmOE.TabIndex = 49
        Me.FrmOE.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmOE, "")
        '
        'LblEspecie22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblEspecie22, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblEspecie22, False)
        Me.LblEspecie22.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.LblEspecie22.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.LblEspecie22, "Default")
        Me.LblEspecie22.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEspecie22.Enabled = False
        Me.LblEspecie22.Location = New System.Drawing.Point(75, 32)
        Me.LblEspecie22.Name = "LblEspecie22"
        Me.LblEspecie22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEspecie22.Size = New System.Drawing.Size(65, 20)
        Me.LblEspecie22.TabIndex = 54
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblEspecie22, "")
        '
        'LblOrigen22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblOrigen22, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblOrigen22, False)
        Me.LblOrigen22.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.LblOrigen22.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.LblOrigen22, "Default")
        Me.LblOrigen22.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOrigen22.Enabled = False
        Me.LblOrigen22.Location = New System.Drawing.Point(75, 10)
        Me.LblOrigen22.Name = "LblOrigen22"
        Me.LblOrigen22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOrigen22.Size = New System.Drawing.Size(65, 20)
        Me.LblOrigen22.TabIndex = 53
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblOrigen22, "")
        '
        'LblEspecie2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblEspecie2, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblEspecie2, False)
        Me.LblEspecie2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.LblEspecie2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.LblEspecie2, "Default")
        Me.LblEspecie2.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblEspecie2.Enabled = False
        Me.LblEspecie2.Location = New System.Drawing.Point(142, 32)
        Me.LblEspecie2.Name = "LblEspecie2"
        Me.LblEspecie2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblEspecie2.Size = New System.Drawing.Size(379, 20)
        Me.LblEspecie2.TabIndex = 52
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblEspecie2, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.AutoSize = True
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(10, 34)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "1330")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(61, 13)
        Me._lblEtiqueta_10.TabIndex = 51
        Me._lblEtiqueta_10.Text = "*Especie:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        'LblOrigen2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.LblOrigen2, False)
        Me.COBISViewResizer.SetAutoResize(Me.LblOrigen2, False)
        Me.LblOrigen2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.LblOrigen2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.LblOrigen2, "Default")
        Me.LblOrigen2.Cursor = System.Windows.Forms.Cursors.Default
        Me.LblOrigen2.Enabled = False
        Me.LblOrigen2.Location = New System.Drawing.Point(142, 10)
        Me.LblOrigen2.Name = "LblOrigen2"
        Me.LblOrigen2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.LblOrigen2.Size = New System.Drawing.Size(379, 20)
        Me.LblOrigen2.TabIndex = 50
        Me.COBISViewResizer.SetWidthRelativeTo(Me.LblOrigen2, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.AutoSize = True
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "1618")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(53, 13)
        Me._lblEtiqueta_9.TabIndex = 49
        Me._lblEtiqueta_9.Text = "*Origen:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        'BtnBuscarCau
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnBuscarCau, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnBuscarCau, False)
        Me.BtnBuscarCau.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnBuscarCau, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnBuscarCau, True)
        Me.BtnBuscarCau.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnBuscarCau, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnBuscarCau, Nothing)
        Me.BtnBuscarCau.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnBuscarCau.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnBuscarCau.Location = New System.Drawing.Point(461, 143)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnBuscarCau, System.Drawing.Color.Silver)
        Me.BtnBuscarCau.Name = "BtnBuscarCau"
        Me.COBISResourceProvider.SetResourceID(Me.BtnBuscarCau, "1027")
        Me.BtnBuscarCau.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnBuscarCau.Size = New System.Drawing.Size(70, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnBuscarCau, 0)
        Me.BtnBuscarCau.TabIndex = 20
        Me.BtnBuscarCau.Text = "*Buscar"
        Me.BtnBuscarCau.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnBuscarCau.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnBuscarCau, "")
        '
        'BtnEliminarCau
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnEliminarCau, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnEliminarCau, False)
        Me.BtnEliminarCau.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnEliminarCau, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnEliminarCau, True)
        Me.BtnEliminarCau.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnEliminarCau, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnEliminarCau, Nothing)
        Me.BtnEliminarCau.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnEliminarCau.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnEliminarCau.Location = New System.Drawing.Point(461, 199)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnEliminarCau, System.Drawing.Color.Silver)
        Me.BtnEliminarCau.Name = "BtnEliminarCau"
        Me.COBISResourceProvider.SetResourceID(Me.BtnEliminarCau, "1312")
        Me.BtnEliminarCau.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnEliminarCau.Size = New System.Drawing.Size(70, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnEliminarCau, 0)
        Me.BtnEliminarCau.TabIndex = 22
        Me.BtnEliminarCau.Tag = "736"
        Me.BtnEliminarCau.Text = "*Eliminar"
        Me.BtnEliminarCau.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnEliminarCau.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnEliminarCau, "")
        '
        'BtnAgregarCau
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.BtnAgregarCau, False)
        Me.COBISViewResizer.SetAutoResize(Me.BtnAgregarCau, False)
        Me.BtnAgregarCau.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.BtnAgregarCau, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.BtnAgregarCau, True)
        Me.BtnAgregarCau.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.BtnAgregarCau, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.BtnAgregarCau, Nothing)
        Me.BtnAgregarCau.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnAgregarCau.ForeColor = System.Drawing.SystemColors.ControlText
        Me.BtnAgregarCau.Location = New System.Drawing.Point(461, 171)
        Me.commandButtonHelper1.SetMaskColor(Me.BtnAgregarCau, System.Drawing.Color.Silver)
        Me.BtnAgregarCau.Name = "BtnAgregarCau"
        Me.COBISResourceProvider.SetResourceID(Me.BtnAgregarCau, "1016")
        Me.BtnAgregarCau.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.BtnAgregarCau.Size = New System.Drawing.Size(70, 25)
        Me.commandButtonHelper1.SetStyle(Me.BtnAgregarCau, 0)
        Me.BtnAgregarCau.TabIndex = 21
        Me.BtnAgregarCau.Tag = "736"
        Me.BtnAgregarCau.Text = "*Agregar"
        Me.BtnAgregarCau.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.BtnAgregarCau.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.BtnAgregarCau, "")
        '
        'grdCausales
        '
        Me.grdCausales._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCausales, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCausales, False)
        Me.grdCausales.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdCausales.Clip = ""
        Me.grdCausales.Col = CType(1, Short)
        Me.grdCausales.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdCausales.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdCausales.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdCausales, "Default")
        Me.grdCausales.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdCausales, True)
        Me.grdCausales.FixedCols = CType(1, Short)
        Me.grdCausales.FixedRows = CType(1, Short)
        Me.grdCausales.ForeColor = System.Drawing.Color.Black
        Me.grdCausales.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdCausales.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdCausales.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdCausales.HighLight = True
        Me.grdCausales.Location = New System.Drawing.Point(6, 125)
        Me.grdCausales.Name = "grdCausales"
        Me.grdCausales.Picture = Nothing
        Me.grdCausales.Row = CType(1, Short)
        Me.grdCausales.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdCausales.Size = New System.Drawing.Size(449, 149)
        Me.grdCausales.Sort = CType(2, Short)
        Me.grdCausales.TabIndex = 19
        Me.grdCausales.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCausales, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.AutoSize = True
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(20, 25)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "1075")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(54, 13)
        Me._lblEtiqueta_8.TabIndex = 44
        Me._lblEtiqueta_8.Text = "*Causal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        'lblCausal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCausal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCausal, False)
        Me.lblCausal.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCausal.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCausal, "Default")
        Me.lblCausal.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCausal.Enabled = False
        Me.lblCausal.Location = New System.Drawing.Point(152, 25)
        Me.lblCausal.Name = "lblCausal"
        Me.lblCausal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCausal.Size = New System.Drawing.Size(379, 20)
        Me.lblCausal.TabIndex = 41
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCausal, "")
        '
        '_grdVariables2_0
        '
        Me._grdVariables2_0._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me._grdVariables2_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._grdVariables2_0, False)
        Me._grdVariables2_0.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me._grdVariables2_0.Clip = ""
        Me._grdVariables2_0.Col = CType(1, Short)
        Me._grdVariables2_0.ColorFixedCols = System.Drawing.SystemColors.Control
        Me._grdVariables2_0.ColorFixedRows = System.Drawing.SystemColors.Control
        Me._grdVariables2_0.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me._grdVariables2_0, "Default")
        Me._grdVariables2_0.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me._grdVariables2_0, True)
        Me._grdVariables2_0.FixedCols = CType(1, Short)
        Me._grdVariables2_0.FixedRows = CType(1, Short)
        Me._grdVariables2_0.ForeColor = System.Drawing.Color.Black
        Me._grdVariables2_0.ForeColorFixedCols = System.Drawing.Color.Empty
        Me._grdVariables2_0.ForeColorFixedRows = System.Drawing.Color.Empty
        Me._grdVariables2_0.GridColor = System.Drawing.SystemColors.ControlDark
        Me._grdVariables2_0.HighLight = True
        Me._grdVariables2_0.Location = New System.Drawing.Point(-3554, -3551)
        Me._grdVariables2_0.Name = "_grdVariables2_0"
        Me._grdVariables2_0.Picture = Nothing
        Me._grdVariables2_0.Row = CType(1, Short)
        Me._grdVariables2_0.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me._grdVariables2_0.Size = New System.Drawing.Size(529, 191)
        Me._grdVariables2_0.Sort = CType(2, Short)
        Me._grdVariables2_0.TabIndex = 27
        Me._grdVariables2_0.TopRow = CType(1, Short)
        Me._grdVariables2_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._grdVariables2_0, "")
        Me.COBISViewResizer.SetxIncrement(Me._grdVariables2_0, False)
        Me.COBISViewResizer.SetyIncrement(Me._grdVariables2_0, False)
        '
        'cmbTipo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbTipo, False)
        Me.cmbTipo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbTipo, "Default")
        Me.cmbTipo.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbTipo.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbTipo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbTipo.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbTipo.Location = New System.Drawing.Point(362, 10)
        Me.cmbTipo.Name = "cmbTipo"
        Me.cmbTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbTipo.Size = New System.Drawing.Size(212, 21)
        Me.cmbTipo.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipo, "")
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
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(516, 74)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 0
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "4129"
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
        Me._cmdBoton_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.Location = New System.Drawing.Point(516, 132)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 25
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "4128"
        Me._cmdBoton_1.Text = "&Crear"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_5.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Image = CType(resources.GetObject("_cmdBoton_5.Image"), System.Drawing.Image)
        Me._cmdBoton_5.Location = New System.Drawing.Point(518, 184)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 26
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Tag = "4128"
        Me._cmdBoton_5.Text = "&Actualizar"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.Location = New System.Drawing.Point(518, 234)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 28
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Tag = "4128"
        Me._cmdBoton_2.Text = "&Eliminar"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_4.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.Location = New System.Drawing.Point(518, 333)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 30
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "&Salir"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.Location = New System.Drawing.Point(518, 283)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 29
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "&Limpiar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdVariables
        '
        Me.grdVariables._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdVariables, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdVariables, False)
        Me.grdVariables.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdVariables.Clip = ""
        Me.grdVariables.Col = CType(1, Short)
        Me.grdVariables.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdVariables.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdVariables.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdVariables, "Default")
        Me.grdVariables.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdVariables, True)
        Me.grdVariables.FixedCols = CType(1, Short)
        Me.grdVariables.FixedRows = CType(1, Short)
        Me.grdVariables.ForeColor = System.Drawing.Color.Black
        Me.grdVariables.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdVariables.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdVariables.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdVariables.HighLight = True
        Me.grdVariables.Location = New System.Drawing.Point(-32776, -32541)
        Me.grdVariables.Name = "grdVariables"
        Me.grdVariables.Picture = Nothing
        Me.grdVariables.Row = CType(1, Short)
        Me.grdVariables.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdVariables.Size = New System.Drawing.Size(54, 37)
        Me.grdVariables.Sort = CType(2, Short)
        Me.grdVariables.TabIndex = 45
        Me.grdVariables.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdVariables, "")
        Me.COBISViewResizer.SetxIncrement(Me.grdVariables, False)
        Me.COBISViewResizer.SetyIncrement(Me.grdVariables, False)
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(290, 10)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1670")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(71, 13)
        Me._lblEtiqueta_1.TabIndex = 10
        Me._lblEtiqueta_1.Text = "*Producto: "
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(66, 10)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(61, 20)
        Me._lblDescripcion_0.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.AutoSize = True
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1168")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(55, 13)
        Me._lblEtiqueta_7.TabIndex = 8
        Me._lblEtiqueta_7.Text = "*Código:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.MhTListaLimites)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me.cmbTipo)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(586, 372)
        Me.PFormas.TabIndex = 46
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(603, 25)
        Me.TSBotones.TabIndex = 47
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBCrear
        '
        Me.TSBCrear.ForeColor = System.Drawing.Color.Black
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "30030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "1004")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.Color.Black
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "30005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "1002")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "30006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "1005")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'Pforma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Pforma, False)
        Me.COBISViewResizer.SetAutoResize(Me.Pforma, False)
        Me.COBISStyleProvider.SetControlStyle(Me.Pforma, "Default")
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(200, 110)
        Me.Pforma.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Pforma, "")
        '
        'FTopesOfiClass
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
        Me.ForeColor = System.Drawing.SystemColors.Highlight
        Me.Location = New System.Drawing.Point(59, 90)
        Me.Name = "FTopesOfiClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(603, 411)
        Me.Text = "*Topes de Retiro por Canal"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.MhTListaLimites.ResumeLayout(False)
        Me._MhTListaLimites_TabPage0.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me._Frame2_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_0.ResumeLayout(False)
        Me._Frame2_0.PerformLayout()
        CType(Me._Frame3_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame3_1.ResumeLayout(False)
        Me._Frame3_1.PerformLayout()
        Me._MhTListaLimites_TabPage1.ResumeLayout(False)
        CType(Me._Frame2_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame2_1.ResumeLayout(False)
        Me._Frame2_1.PerformLayout()
        CType(Me.FrmLImD, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmLImD.ResumeLayout(False)
        Me.FrmLImD.PerformLayout()
        CType(Me.grdLimites, System.ComponentModel.ISupportInitialize).EndInit()
        Me._MhTListaLimites_TabPage2.ResumeLayout(False)
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        CType(Me.FrmOE, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmOE.ResumeLayout(False)
        Me.FrmOE.PerformLayout()
        CType(Me.grdCausales, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._grdVariables2_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdVariables, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializemskMonto()
        Me.mskMonto(3) = _mskMonto_3
        Me.mskMonto(4) = _mskMonto_4
        Me.mskMonto(1) = _mskMonto_1
        Me.mskMonto(2) = _mskMonto_2
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(7) = _lblEtiqueta_7
    End Sub
    Sub InitializelblDescripcionOo()
        Me.lblDescripcionOo(2) = _lblDescripcionOo_2
        Me.lblDescripcionOo(1) = _lblDescripcionOo_1
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializegrdVariables2()
        Me.grdVariables2(0) = _grdVariables2_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Sub InitializeFrame3()
        Me.Frame3(1) = _Frame3_1
    End Sub
    Sub InitializeFrame2()
        Me.Frame2(1) = _Frame2_1
        Me.Frame2(0) = _Frame2_0
    End Sub
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents FrmOE As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents LblEspecie22 As System.Windows.Forms.Label
    Public WithEvents LblOrigen22 As System.Windows.Forms.Label
    Public WithEvents LblEspecie2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Public WithEvents LblOrigen2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Public WithEvents BtnBuscarCau As System.Windows.Forms.Button
    Public WithEvents BtnEliminarCau As System.Windows.Forms.Button
    Public WithEvents BtnAgregarCau As System.Windows.Forms.Button
    Public WithEvents grdCausales As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Public WithEvents lblCausal As System.Windows.Forms.Label
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TextEspecie As System.Windows.Forms.TextBox
    Friend WithEvents txtOrigen As System.Windows.Forms.TextBox
    Friend WithEvents TextCausal As System.Windows.Forms.TextBox
    Private WithEvents mskMontoRetiro As COBISCorp.Framework.UI.Components.CobisRealInput
    Public WithEvents Check1 As System.Windows.Forms.CheckBox
    Public WithEvents Check2 As System.Windows.Forms.CheckBox
    Public WithEvents Check4 As System.Windows.Forms.CheckBox
    Public WithEvents Check3 As System.Windows.Forms.CheckBox
    Friend WithEvents mskNumTx As System.Windows.Forms.TextBox
#End Region
End Class


