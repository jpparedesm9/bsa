Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FPExenGMFClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		Initializetxtcampo()
		Initializeoptucta()
		Initializeopttope()
		Initializeopttitular()
		Initializelbletiqueta()
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
    Private WithEvents _txtcampo_12 As System.Windows.Forms.TextBox
    Public WithEvents Txtdescripcionc As System.Windows.Forms.TextBox
    Public WithEvents CmbPers As System.Windows.Forms.ComboBox
    Public WithEvents cmbTipo As System.Windows.Forms.ComboBox
    Public WithEvents txtnemo As System.Windows.Forms.TextBox
    Public WithEvents txtdescripcion As System.Windows.Forms.TextBox
    Private WithEvents _lbletiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_2 As System.Windows.Forms.Label
    Public WithEvents lblConcepto As System.Windows.Forms.Label
    Public WithEvents SSFrame5 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optucta_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optucta_1 As System.Windows.Forms.RadioButton
    Public WithEvents txtCampotxtCampo As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _opttitular_0 As System.Windows.Forms.RadioButton
    Private WithEvents _opttitular_1 As System.Windows.Forms.RadioButton
    Public WithEvents SSFrame2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _opttope_0 As System.Windows.Forms.RadioButton
    Private WithEvents _opttope_1 As System.Windows.Forms.RadioButton
    Public WithEvents SSFrame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents mskValor As COBISCorp.Framework.UI.Components.CobisRealInput
    Public WithEvents Msktasa As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _lbletiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_1 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
	Public cmdBoton(6) As System.Windows.Forms.Button
	Public lbletiqueta(13) As System.Windows.Forms.Label
	Public opttitular(1) As System.Windows.Forms.RadioButton
	Public opttope(1) As System.Windows.Forms.RadioButton
	Public optucta(1) As System.Windows.Forms.RadioButton
	Public txtcampo(12) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FPExenGMFClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtcampo_12 = New System.Windows.Forms.TextBox()
        Me.Txtdescripcionc = New System.Windows.Forms.TextBox()
        Me.CmbPers = New System.Windows.Forms.ComboBox()
        Me.SSFrame5 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cmbTipo = New System.Windows.Forms.ComboBox()
        Me.txtnemo = New System.Windows.Forms.TextBox()
        Me.txtdescripcion = New System.Windows.Forms.TextBox()
        Me._lbletiqueta_5 = New System.Windows.Forms.Label()
        Me._lbletiqueta_9 = New System.Windows.Forms.Label()
        Me._lbletiqueta_0 = New System.Windows.Forms.Label()
        Me._lbletiqueta_2 = New System.Windows.Forms.Label()
        Me.lblConcepto = New System.Windows.Forms.Label()
        Me.txtCampotxtCampo = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optucta_0 = New System.Windows.Forms.RadioButton()
        Me._optucta_1 = New System.Windows.Forms.RadioButton()
        Me.SSFrame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._opttitular_0 = New System.Windows.Forms.RadioButton()
        Me._opttitular_1 = New System.Windows.Forms.RadioButton()
        Me.SSFrame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._opttope_0 = New System.Windows.Forms.RadioButton()
        Me._opttope_1 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.mskValor = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me.Msktasa = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lbletiqueta_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_4 = New System.Windows.Forms.Label()
        Me._lbletiqueta_3 = New System.Windows.Forms.Label()
        Me._lbletiqueta_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.gbRegistros = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.SSFrame5, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SSFrame5.SuspendLayout()
        CType(Me.txtCampotxtCampo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.txtCampotxtCampo.SuspendLayout()
        CType(Me.SSFrame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SSFrame2.SuspendLayout()
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SSFrame1.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.gbRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.gbRegistros.SuspendLayout()
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
        '_txtcampo_12
        '
        Me._txtcampo_12.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_12, False)
        Me._txtcampo_12.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_12, "Default")
        Me._txtcampo_12.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_12.Location = New System.Drawing.Point(104, 193)
        Me._txtcampo_12.MaxLength = 2
        Me._txtcampo_12.Name = "_txtcampo_12"
        Me._txtcampo_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_12.Size = New System.Drawing.Size(45, 20)
        Me._txtcampo_12.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_12, "")
        '
        'Txtdescripcionc
        '
        Me.Txtdescripcionc.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.Txtdescripcionc, False)
        Me.COBISViewResizer.SetAutoResize(Me.Txtdescripcionc, False)
        Me.Txtdescripcionc.BackColor = System.Drawing.Color.Silver
        Me.COBISStyleProvider.SetControlStyle(Me.Txtdescripcionc, "Default")
        Me.Txtdescripcionc.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.Txtdescripcionc.Location = New System.Drawing.Point(152, 193)
        Me.Txtdescripcionc.MaxLength = 64
        Me.Txtdescripcionc.Name = "Txtdescripcionc"
        Me.Txtdescripcionc.ReadOnly = True
        Me.Txtdescripcionc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Txtdescripcionc.Size = New System.Drawing.Size(426, 20)
        Me.Txtdescripcionc.TabIndex = 34
        Me.Txtdescripcionc.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Txtdescripcionc, "")
        '
        'CmbPers
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.CmbPers, False)
        Me.COBISViewResizer.SetAutoResize(Me.CmbPers, False)
        Me.CmbPers.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.CmbPers, "Default")
        Me.CmbPers.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmbPers.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CmbPers.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CmbPers.Location = New System.Drawing.Point(110, 113)
        Me.CmbPers.Name = "CmbPers"
        Me.CmbPers.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmbPers.Size = New System.Drawing.Size(162, 21)
        Me.CmbPers.TabIndex = 5
        Me.CmbPers.Tag = "4"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.CmbPers, "")
        '
        'SSFrame5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.SSFrame5, False)
        Me.COBISViewResizer.SetAutoResize(Me.SSFrame5, False)
        Me.SSFrame5.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.SSFrame5.Controls.Add(Me.cmbTipo)
        Me.SSFrame5.Controls.Add(Me.txtnemo)
        Me.SSFrame5.Controls.Add(Me.txtdescripcion)
        Me.SSFrame5.Controls.Add(Me._lbletiqueta_5)
        Me.SSFrame5.Controls.Add(Me._lbletiqueta_9)
        Me.SSFrame5.Controls.Add(Me._lbletiqueta_0)
        Me.SSFrame5.Controls.Add(Me._lbletiqueta_2)
        Me.SSFrame5.Controls.Add(Me.lblConcepto)
        Me.COBISStyleProvider.SetControlStyle(Me.SSFrame5, "Default")
        Me.SSFrame5.ForeColor = System.Drawing.Color.Navy
        Me.SSFrame5.Location = New System.Drawing.Point(10, 10)
        Me.SSFrame5.Name = "SSFrame5"
        Me.SSFrame5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SSFrame5.Size = New System.Drawing.Size(582, 90)
        Me.SSFrame5.TabIndex = 1
        Me.SSFrame5.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.SSFrame5, "")
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
        Me.cmbTipo.Location = New System.Drawing.Point(94, 61)
        Me.cmbTipo.Name = "cmbTipo"
        Me.cmbTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbTipo.Size = New System.Drawing.Size(163, 21)
        Me.cmbTipo.TabIndex = 3
        Me.cmbTipo.Tag = "2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbTipo, "")
        '
        'txtnemo
        '
        Me.txtnemo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtnemo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtnemo, False)
        Me.txtnemo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtnemo, "Default")
        Me.txtnemo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtnemo.Location = New System.Drawing.Point(489, 60)
        Me.txtnemo.MaxLength = 5
        Me.txtnemo.Name = "txtnemo"
        Me.txtnemo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtnemo.Size = New System.Drawing.Size(79, 20)
        Me.txtnemo.TabIndex = 4
        Me.txtnemo.Tag = "3"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtnemo, "")
        '
        'txtdescripcion
        '
        Me.txtdescripcion.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtdescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtdescripcion, False)
        Me.txtdescripcion.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtdescripcion, "Default")
        Me.txtdescripcion.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtdescripcion.Location = New System.Drawing.Point(94, 38)
        Me.txtdescripcion.MaxLength = 65
        Me.txtdescripcion.Multiline = True
        Me.txtdescripcion.Name = "txtdescripcion"
        Me.txtdescripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtdescripcion.Size = New System.Drawing.Size(474, 20)
        Me.txtdescripcion.TabIndex = 2
        Me.txtdescripcion.Tag = "1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtdescripcion, "")
        '
        '_lbletiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_5, False)
        Me._lbletiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_5, "Default")
        Me._lbletiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_5.Location = New System.Drawing.Point(10, 60)
        Me._lbletiqueta_5.Name = "_lbletiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_5, "502808")
        Me._lbletiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_5.Size = New System.Drawing.Size(81, 20)
        Me._lbletiqueta_5.TabIndex = 30
        Me._lbletiqueta_5.Text = "*Producto :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_5, "")
        '
        '_lbletiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_9, False)
        Me._lbletiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_9, "Default")
        Me._lbletiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_9.Location = New System.Drawing.Point(410, 60)
        Me._lbletiqueta_9.Name = "_lbletiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_9, "502809")
        Me._lbletiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_9.Size = New System.Drawing.Size(65, 20)
        Me._lbletiqueta_9.TabIndex = 28
        Me._lbletiqueta_9.Text = "*Nemonico :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_9, "")
        '
        '_lbletiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_0, False)
        Me._lbletiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_0, "Default")
        Me._lbletiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_0.Location = New System.Drawing.Point(10, 12)
        Me._lbletiqueta_0.Name = "_lbletiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_0, "9913")
        Me._lbletiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_0.Size = New System.Drawing.Size(81, 20)
        Me._lbletiqueta_0.TabIndex = 27
        Me._lbletiqueta_0.Text = "*Concepto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_0, "")
        '
        '_lbletiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_2, False)
        Me._lbletiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_2, "Default")
        Me._lbletiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_2.Location = New System.Drawing.Point(10, 35)
        Me._lbletiqueta_2.Name = "_lbletiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_2, "500643")
        Me._lbletiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_2.Size = New System.Drawing.Size(81, 20)
        Me._lbletiqueta_2.TabIndex = 26
        Me._lbletiqueta_2.Text = "*Descripción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_2, "")
        '
        'lblConcepto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblConcepto, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblConcepto, False)
        Me.lblConcepto.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblConcepto.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblConcepto, "Default")
        Me.lblConcepto.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblConcepto.Location = New System.Drawing.Point(94, 15)
        Me.lblConcepto.Name = "lblConcepto"
        Me.lblConcepto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblConcepto.Size = New System.Drawing.Size(70, 20)
        Me.lblConcepto.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblConcepto, "")
        '
        'txtCampotxtCampo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCampotxtCampo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCampotxtCampo, False)
        Me.txtCampotxtCampo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.txtCampotxtCampo.Controls.Add(Me._optucta_0)
        Me.txtCampotxtCampo.Controls.Add(Me._optucta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.txtCampotxtCampo, "Default")
        Me.txtCampotxtCampo.ForeColor = System.Drawing.Color.Navy
        Me.txtCampotxtCampo.Location = New System.Drawing.Point(441, 147)
        Me.txtCampotxtCampo.Name = "txtCampotxtCampo"
        Me.COBISResourceProvider.SetResourceID(Me.txtCampotxtCampo, "502814")
        Me.txtCampotxtCampo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCampotxtCampo.Size = New System.Drawing.Size(152, 39)
        Me.txtCampotxtCampo.TabIndex = 14
        Me.txtCampotxtCampo.Tag = "9"
        Me.txtCampotxtCampo.Text = "*Permite Otra Exenta"
        Me.txtCampotxtCampo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCampotxtCampo, "")
        '
        '_optucta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optucta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optucta_0, False)
        Me._optucta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optucta_0, "Default")
        Me._optucta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optucta_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optucta_0.Location = New System.Drawing.Point(17, 19)
        Me._optucta_0.Name = "_optucta_0"
        Me.COBISResourceProvider.SetResourceID(Me._optucta_0, "5118")
        Me._optucta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optucta_0.Size = New System.Drawing.Size(49, 15)
        Me._optucta_0.TabIndex = 15
        Me._optucta_0.TabStop = True
        Me._optucta_0.Tag = "11"
        Me._optucta_0.Text = "*Si"
        Me._optucta_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optucta_0, "")
        '
        '_optucta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optucta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optucta_1, False)
        Me._optucta_1.BackColor = System.Drawing.Color.Transparent
        Me._optucta_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optucta_1, "Default")
        Me._optucta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optucta_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._optucta_1.Location = New System.Drawing.Point(90, 17)
        Me._optucta_1.Name = "_optucta_1"
        Me.COBISResourceProvider.SetResourceID(Me._optucta_1, "5119")
        Me._optucta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optucta_1.Size = New System.Drawing.Size(52, 15)
        Me._optucta_1.TabIndex = 16
        Me._optucta_1.TabStop = True
        Me._optucta_1.Tag = "12"
        Me._optucta_1.Text = "*No"
        Me._optucta_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optucta_1, "")
        '
        'SSFrame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.SSFrame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.SSFrame2, False)
        Me.SSFrame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.SSFrame2.Controls.Add(Me._opttitular_0)
        Me.SSFrame2.Controls.Add(Me._opttitular_1)
        Me.COBISStyleProvider.SetControlStyle(Me.SSFrame2, "Default")
        Me.SSFrame2.ForeColor = System.Drawing.Color.Navy
        Me.SSFrame2.Location = New System.Drawing.Point(440, 108)
        Me.SSFrame2.Name = "SSFrame2"
        Me.COBISResourceProvider.SetResourceID(Me.SSFrame2, "502811")
        Me.SSFrame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SSFrame2.Size = New System.Drawing.Size(152, 37)
        Me.SSFrame2.TabIndex = 11
        Me.SSFrame2.Tag = "5"
        Me.SSFrame2.Text = "*Titular"
        Me.SSFrame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.SSFrame2, "")
        '
        '_opttitular_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._opttitular_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._opttitular_0, False)
        Me._opttitular_0.BackColor = System.Drawing.Color.Transparent
        Me._opttitular_0.CausesValidation = False
        Me._opttitular_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._opttitular_0, "Default")
        Me._opttitular_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._opttitular_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._opttitular_0.Location = New System.Drawing.Point(18, 19)
        Me._opttitular_0.Name = "_opttitular_0"
        Me.COBISResourceProvider.SetResourceID(Me._opttitular_0, "5118")
        Me._opttitular_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._opttitular_0.Size = New System.Drawing.Size(45, 15)
        Me._opttitular_0.TabIndex = 12
        Me._opttitular_0.TabStop = True
        Me._opttitular_0.Tag = "5"
        Me._opttitular_0.Text = "*Si"
        Me._opttitular_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._opttitular_0, "")
        '
        '_opttitular_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._opttitular_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._opttitular_1, False)
        Me._opttitular_1.BackColor = System.Drawing.Color.Transparent
        Me._opttitular_1.CausesValidation = False
        Me.COBISStyleProvider.SetControlStyle(Me._opttitular_1, "Default")
        Me._opttitular_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._opttitular_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._opttitular_1.Location = New System.Drawing.Point(91, 18)
        Me._opttitular_1.Name = "_opttitular_1"
        Me.COBISResourceProvider.SetResourceID(Me._opttitular_1, "5119")
        Me._opttitular_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._opttitular_1.Size = New System.Drawing.Size(50, 15)
        Me._opttitular_1.TabIndex = 13
        Me._opttitular_1.TabStop = True
        Me._opttitular_1.Tag = "6"
        Me._opttitular_1.Text = "*No"
        Me._opttitular_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._opttitular_1, "")
        '
        'SSFrame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.SSFrame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.SSFrame1, False)
        Me.SSFrame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.SSFrame1.Controls.Add(Me._opttope_0)
        Me.SSFrame1.Controls.Add(Me._opttope_1)
        Me.COBISStyleProvider.SetControlStyle(Me.SSFrame1, "Default")
        Me.SSFrame1.ForeColor = System.Drawing.Color.Navy
        Me.SSFrame1.Location = New System.Drawing.Point(10, 140)
        Me.SSFrame1.Name = "SSFrame1"
        Me.COBISResourceProvider.SetResourceID(Me.SSFrame1, "503159")
        Me.SSFrame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.SSFrame1.Size = New System.Drawing.Size(114, 40)
        Me.SSFrame1.TabIndex = 6
        Me.SSFrame1.Tag = "6"
        Me.SSFrame1.Text = "*Tope"
        Me.SSFrame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.SSFrame1, "")
        '
        '_opttope_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._opttope_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._opttope_0, False)
        Me._opttope_0.BackColor = System.Drawing.Color.Transparent
        Me._opttope_0.CausesValidation = False
        Me._opttope_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._opttope_0, "Default")
        Me._opttope_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._opttope_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._opttope_0.Location = New System.Drawing.Point(13, 18)
        Me._opttope_0.Name = "_opttope_0"
        Me.COBISResourceProvider.SetResourceID(Me._opttope_0, "5118")
        Me._opttope_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._opttope_0.Size = New System.Drawing.Size(46, 15)
        Me._opttope_0.TabIndex = 7
        Me._opttope_0.TabStop = True
        Me._opttope_0.Tag = "7"
        Me._opttope_0.Text = "*Si"
        Me._opttope_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._opttope_0, "")
        '
        '_opttope_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._opttope_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._opttope_1, False)
        Me._opttope_1.BackColor = System.Drawing.Color.Transparent
        Me._opttope_1.CausesValidation = False
        Me.COBISStyleProvider.SetControlStyle(Me._opttope_1, "Default")
        Me._opttope_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._opttope_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._opttope_1.Location = New System.Drawing.Point(65, 15)
        Me._opttope_1.Name = "_opttope_1"
        Me.COBISResourceProvider.SetResourceID(Me._opttope_1, "5119")
        Me._opttope_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._opttope_1.Size = New System.Drawing.Size(45, 21)
        Me._opttope_1.TabIndex = 8
        Me._opttope_1.Tag = "8"
        Me._opttope_1.Text = "*No"
        Me._opttope_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._opttope_1, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-671, 55)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 10
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "4108"
        Me._cmdBoton_1.Text = "*Si&guientes"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me.grdRegistros.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(3, 16)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(576, 155)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 18
        Me.grdRegistros.Tag = "11"
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-671, 107)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 11
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Tag = "4102"
        Me._cmdBoton_2.Text = "*&Crear"
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
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-671, 282)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 14
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*&Limpiar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_6.Location = New System.Drawing.Point(-671, 334)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 15
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Text = "*&Salir"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-671, 3)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 9
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "4108"
        Me._cmdBoton_0.Text = "*&Buscar"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-671, 212)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 13
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Tag = "4104"
        Me._cmdBoton_4.Text = "*&Eliminar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me._cmdBoton_4.Visible = False
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-671, 159)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(68, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 12
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "4103"
        Me._cmdBoton_3.Text = "*&Actualizar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.mskValor.BackColor = System.Drawing.SystemColors.Window
        Me.mskValor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.DecimalPlaces = 2
        Me.mskValor.Enabled = False
        Me.mskValor.Location = New System.Drawing.Point(201, 159)
        Me.mskValor.MaxReal = 3.4E+38!
        Me.mskValor.MinReal = 0.0!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.ScrollBars = System.Windows.Forms.ScrollBars.Horizontal
        Me.mskValor.Separator = True
        Me.mskValor.Size = New System.Drawing.Size(107, 20)
        Me.mskValor.TabIndex = 9
        Me.mskValor.Tag = "7"
        Me.mskValor.Text = "0.00"
        Me.mskValor.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskValor.ValueDouble = 0.0R
        Me.mskValor.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'Msktasa
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Msktasa, False)
        Me.COBISViewResizer.SetAutoResize(Me.Msktasa, False)
        Me.Msktasa.BackColor = System.Drawing.SystemColors.Window
        Me.Msktasa.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.Msktasa, "Default")
        Me.Msktasa.DecimalPlaces = 3
        Me.Msktasa.Location = New System.Drawing.Point(353, 159)
        Me.Msktasa.MaxReal = 3.4E+38!
        Me.Msktasa.MinReal = 0.0!
        Me.Msktasa.Name = "Msktasa"
        Me.Msktasa.ScrollBars = System.Windows.Forms.ScrollBars.Horizontal
        Me.Msktasa.Separator = True
        Me.Msktasa.Size = New System.Drawing.Size(61, 20)
        Me.Msktasa.TabIndex = 10
        Me.Msktasa.Tag = "8"
        Me.Msktasa.Text = "0.000"
        Me.Msktasa.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.Msktasa.ValueDouble = 0.0R
        Me.Msktasa.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Msktasa, "")
        '
        '_lbletiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_6, False)
        Me._lbletiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_6, "Default")
        Me._lbletiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_6.Location = New System.Drawing.Point(10, 193)
        Me._lbletiqueta_6.Name = "_lbletiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_6, "503162")
        Me._lbletiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_6.Size = New System.Drawing.Size(91, 18)
        Me._lbletiqueta_6.TabIndex = 33
        Me._lbletiqueta_6.Text = "*Otro Concepto :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_6, "")
        '
        '_lbletiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_4, False)
        Me._lbletiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_4, "Default")
        Me._lbletiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_4.Location = New System.Drawing.Point(312, 159)
        Me._lbletiqueta_4.Name = "_lbletiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_4, "502159")
        Me._lbletiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_4.Size = New System.Drawing.Size(35, 20)
        Me._lbletiqueta_4.TabIndex = 32
        Me._lbletiqueta_4.Text = "*Tasa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_4, "")
        '
        '_lbletiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_3, False)
        Me._lbletiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_3, "Default")
        Me._lbletiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_3.Location = New System.Drawing.Point(132, 159)
        Me._lbletiqueta_3.Name = "_lbletiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_3, "502813")
        Me._lbletiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_3.Size = New System.Drawing.Size(73, 20)
        Me._lbletiqueta_3.TabIndex = 31
        Me._lbletiqueta_3.Text = "*Valor Tope:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_3, "")
        '
        '_lbletiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_1, False)
        Me._lbletiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_1, "Default")
        Me._lbletiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_1.Location = New System.Drawing.Point(18, 113)
        Me._lbletiqueta_1.Name = "_lbletiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_1, "502810")
        Me._lbletiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_1.Size = New System.Drawing.Size(110, 20)
        Me._lbletiqueta_1.TabIndex = 29
        Me._lbletiqueta_1.Text = "*Tipo de Persona:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.gbRegistros)
        Me.PFormas.Controls.Add(Me.SSFrame2)
        Me.PFormas.Controls.Add(Me.txtCampotxtCampo)
        Me.PFormas.Controls.Add(Me.SSFrame1)
        Me.PFormas.Controls.Add(Me.mskValor)
        Me.PFormas.Controls.Add(Me.CmbPers)
        Me.PFormas.Controls.Add(Me._txtcampo_12)
        Me.PFormas.Controls.Add(Me.Txtdescripcionc)
        Me.PFormas.Controls.Add(Me._lbletiqueta_1)
        Me.PFormas.Controls.Add(Me._lbletiqueta_3)
        Me.PFormas.Controls.Add(Me.SSFrame5)
        Me.PFormas.Controls.Add(Me._lbletiqueta_4)
        Me.PFormas.Controls.Add(Me._lbletiqueta_6)
        Me.PFormas.Controls.Add(Me.Msktasa)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(602, 402)
        Me.PFormas.TabIndex = 0
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'gbRegistros
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.gbRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.gbRegistros, False)
        Me.gbRegistros.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.gbRegistros.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.gbRegistros, "Default")
        Me.gbRegistros.ForeColor = System.Drawing.Color.Navy
        Me.gbRegistros.Location = New System.Drawing.Point(10, 222)
        Me.gbRegistros.Name = "gbRegistros"
        Me.COBISResourceProvider.SetResourceID(Me.gbRegistros, "503163")
        Me.gbRegistros.Size = New System.Drawing.Size(582, 174)
        Me.gbRegistros.TabIndex = 17
        Me.gbRegistros.Text = "*Registros"
        Me.gbRegistros.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.gbRegistros, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(619, 25)
        Me.TSBotones.TabIndex = 39
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
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
        'TSBSiguiente
        '
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguiente.Text = "*Si&guientes"
        '
        'TSBCrear
        '
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2027")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
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
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FPExenGMFClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_6)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FPExenGMFClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(619, 448)
        Me.Text = "*Conceptos de Exención Gravamen Movimiento Financiero"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.SSFrame5, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SSFrame5.ResumeLayout(False)
        Me.SSFrame5.PerformLayout()
        CType(Me.txtCampotxtCampo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.txtCampotxtCampo.ResumeLayout(False)
        CType(Me.SSFrame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SSFrame2.ResumeLayout(False)
        CType(Me.SSFrame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.SSFrame1.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.gbRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        Me.gbRegistros.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub Initializetxtcampo()
        Me.txtcampo(12) = _txtcampo_12
    End Sub
    Sub Initializeoptucta()
        Me.optucta(0) = _optucta_0
        Me.optucta(1) = _optucta_1
    End Sub
    Sub Initializeopttope()
        Me.opttope(0) = _opttope_0
        Me.opttope(1) = _opttope_1
    End Sub
    Sub Initializeopttitular()
        Me.opttitular(0) = _opttitular_0
        Me.opttitular(1) = _opttitular_1
    End Sub
    Sub Initializelbletiqueta()
        Me.lbletiqueta(5) = _lbletiqueta_5
        Me.lbletiqueta(9) = _lbletiqueta_9
        Me.lbletiqueta(0) = _lbletiqueta_0
        Me.lbletiqueta(2) = _lbletiqueta_2
        Me.lbletiqueta(6) = _lbletiqueta_6
        Me.lbletiqueta(4) = _lbletiqueta_4
        Me.lbletiqueta(3) = _lbletiqueta_3
        Me.lbletiqueta(1) = _lbletiqueta_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents gbRegistros As Infragistics.Win.Misc.UltraGroupBox
#End Region 
End Class


