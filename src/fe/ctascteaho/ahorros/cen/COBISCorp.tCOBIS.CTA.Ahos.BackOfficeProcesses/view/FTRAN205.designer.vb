Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FTran205Class
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		Initializeoptdir()
		Initializeoptcausa()
		InitializeoptDirecciondv()
		InitializeoptDireccion()
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
    Private WithEvents _optDireccion_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_3 As System.Windows.Forms.RadioButton
    Public WithEvents frmDirecciones As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optDirecciondv_3 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_0 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1dv As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_13 As System.Windows.Forms.TextBox
    Private WithEvents _optdir_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optdir_1 As System.Windows.Forms.RadioButton
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _optcausa_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optcausa_0 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Public WithEvents chkFuncionario As System.Windows.Forms.CheckBox
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_19 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
	Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
	Public Line1(2) As System.Windows.Forms.Label
	Public cmdBoton(4) As System.Windows.Forms.Button
	Public lblDescripcion(14) As System.Windows.Forms.Label
	Public lblEtiqueta(19) As System.Windows.Forms.Label
	Public optDireccion(3) As System.Windows.Forms.RadioButton
	Public optDirecciondv(3) As System.Windows.Forms.RadioButton
	Public optcausa(1) As System.Windows.Forms.RadioButton
	Public optdir(1) As System.Windows.Forms.RadioButton
	Public txtCampo(13) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran205Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.frmDirecciones = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optDireccion_0 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_1 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_2 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_3 = New System.Windows.Forms.RadioButton()
        Me.Frame1dv = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optDirecciondv_3 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_2 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_1 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_0 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_13 = New System.Windows.Forms.TextBox()
        Me._optdir_0 = New System.Windows.Forms.RadioButton()
        Me._optdir_1 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optcausa_1 = New System.Windows.Forms.RadioButton()
        Me._optcausa_0 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me.chkFuncionario = New System.Windows.Forms.CheckBox()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_19 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBeneficiarios = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.frmDirecciones, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmDirecciones.SuspendLayout()
        CType(Me.Frame1dv, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1dv.SuspendLayout()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBBotones.SuspendLayout()
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
        'frmDirecciones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmDirecciones, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmDirecciones, False)
        Me.frmDirecciones.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmDirecciones.Controls.Add(Me._optDireccion_0)
        Me.frmDirecciones.Controls.Add(Me._optDireccion_1)
        Me.frmDirecciones.Controls.Add(Me._optDireccion_2)
        Me.frmDirecciones.Controls.Add(Me._optDireccion_3)
        Me.COBISStyleProvider.SetControlStyle(Me.frmDirecciones, "Default")
        Me.frmDirecciones.ForeColor = System.Drawing.Color.Navy
        Me.frmDirecciones.Location = New System.Drawing.Point(178, 293)
        Me.frmDirecciones.Name = "frmDirecciones"
        Me.frmDirecciones.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmDirecciones.Size = New System.Drawing.Size(218, 80)
        Me.frmDirecciones.TabIndex = 43
        Me.frmDirecciones.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmDirecciones, "")
        '
        '_optDireccion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_0, False)
        Me._optDireccion_0.BackColor = System.Drawing.Color.Transparent
        Me._optDireccion_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_0, "Default")
        Me._optDireccion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_0.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_0.Location = New System.Drawing.Point(3, 8)
        Me._optDireccion_0.Name = "_optDireccion_0"
        Me.COBISResourceProvider.SetResourceID(Me._optDireccion_0, "501163")
        Me._optDireccion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_0.Size = New System.Drawing.Size(203, 20)
        Me._optDireccion_0.TabIndex = 44
        Me._optDireccion_0.TabStop = True
        Me._optDireccion_0.Text = "*Enviar a dirección del cliente"
        Me._optDireccion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_0, "")
        '
        '_optDireccion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_1, False)
        Me._optDireccion_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_1, "Default")
        Me._optDireccion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_1.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_1.Location = New System.Drawing.Point(3, 24)
        Me._optDireccion_1.Name = "_optDireccion_1"
        Me.COBISResourceProvider.SetResourceID(Me._optDireccion_1, "501161")
        Me._optDireccion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_1.Size = New System.Drawing.Size(223, 20)
        Me._optDireccion_1.TabIndex = 45
        Me._optDireccion_1.TabStop = True
        Me._optDireccion_1.Text = "*Enviar a casilla postal del cliente"
        Me._optDireccion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_1, "")
        '
        '_optDireccion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_2, False)
        Me._optDireccion_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_2, "Default")
        Me._optDireccion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_2.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_2.Location = New System.Drawing.Point(3, 41)
        Me._optDireccion_2.Name = "_optDireccion_2"
        Me.COBISResourceProvider.SetResourceID(Me._optDireccion_2, "501274")
        Me._optDireccion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_2.Size = New System.Drawing.Size(223, 20)
        Me._optDireccion_2.TabIndex = 46
        Me._optDireccion_2.TabStop = True
        Me._optDireccion_2.Text = "*Retener en agencia del banco"
        Me._optDireccion_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_2, "")
        '
        '_optDireccion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_3, False)
        Me._optDireccion_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_3, "Default")
        Me._optDireccion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_3.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_3.Location = New System.Drawing.Point(3, 59)
        Me._optDireccion_3.Name = "_optDireccion_3"
        Me.COBISResourceProvider.SetResourceID(Me._optDireccion_3, "501164")
        Me._optDireccion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_3.Size = New System.Drawing.Size(223, 18)
        Me._optDireccion_3.TabIndex = 47
        Me._optDireccion_3.TabStop = True
        Me._optDireccion_3.Text = "*Retener en casillero del banco"
        Me._optDireccion_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_3, "")
        '
        'Frame1dv
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1dv, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1dv, False)
        Me.Frame1dv.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1dv.Controls.Add(Me._optDirecciondv_3)
        Me.Frame1dv.Controls.Add(Me._optDirecciondv_2)
        Me.Frame1dv.Controls.Add(Me._optDirecciondv_1)
        Me.Frame1dv.Controls.Add(Me._optDirecciondv_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1dv, "Default")
        Me.Frame1dv.ForeColor = System.Drawing.Color.Navy
        Me.Frame1dv.Location = New System.Drawing.Point(178, 304)
        Me.Frame1dv.Name = "Frame1dv"
        Me.Frame1dv.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1dv.Size = New System.Drawing.Size(178, 63)
        Me.Frame1dv.TabIndex = 38
        Me.Frame1dv.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.Frame1dv.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1dv, "")
        '
        '_optDirecciondv_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_3, False)
        Me._optDirecciondv_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_3, "Default")
        Me._optDirecciondv_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_3.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_3.Location = New System.Drawing.Point(3, 48)
        Me._optDirecciondv_3.Name = "_optDirecciondv_3"
        Me._optDirecciondv_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_3.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_3.TabIndex = 39
        Me._optDirecciondv_3.Text = "Retener en casillero del banco"
        Me._optDirecciondv_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_3, "")
        '
        '_optDirecciondv_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_2, False)
        Me._optDirecciondv_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_2, "Default")
        Me._optDirecciondv_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_2.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_2.Location = New System.Drawing.Point(3, 36)
        Me._optDirecciondv_2.Name = "_optDirecciondv_2"
        Me._optDirecciondv_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_2.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_2.TabIndex = 40
        Me._optDirecciondv_2.Text = "Retener en agencia del banco"
        Me._optDirecciondv_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_2, "")
        '
        '_optDirecciondv_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_1, False)
        Me._optDirecciondv_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_1, "Default")
        Me._optDirecciondv_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_1.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_1.Location = New System.Drawing.Point(3, 23)
        Me._optDirecciondv_1.Name = "_optDirecciondv_1"
        Me._optDirecciondv_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_1.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_1.TabIndex = 41
        Me._optDirecciondv_1.Text = "Enviar a casilla postal del cliente"
        Me._optDirecciondv_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_1, "")
        '
        '_optDirecciondv_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_0, False)
        Me._optDirecciondv_0.BackColor = System.Drawing.Color.Transparent
        Me._optDirecciondv_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_0, "Default")
        Me._optDirecciondv_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_0.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_0.Location = New System.Drawing.Point(3, 10)
        Me._optDirecciondv_0.Name = "_optDirecciondv_0"
        Me._optDirecciondv_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_0.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_0.TabIndex = 42
        Me._optDirecciondv_0.TabStop = True
        Me._optDirecciondv_0.Text = "Enviar a dirección del cliente"
        Me._optDirecciondv_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_0, "")
        '
        '_txtCampo_13
        '
        Me._txtCampo_13.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_13, False)
        Me._txtCampo_13.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_13, "Default")
        Me._txtCampo_13.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_13.Location = New System.Drawing.Point(402, 330)
        Me._txtCampo_13.MaxLength = 4
        Me._txtCampo_13.Name = "_txtCampo_13"
        Me._txtCampo_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_13.Size = New System.Drawing.Size(183, 20)
        Me._txtCampo_13.TabIndex = 35
        Me._txtCampo_13.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_13, "")
        '
        '_optdir_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optdir_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optdir_0, False)
        Me._optdir_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optdir_0, "Default")
        Me._optdir_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optdir_0.Enabled = False
        Me._optdir_0.ForeColor = System.Drawing.Color.Navy
        Me._optdir_0.Location = New System.Drawing.Point(26, 324)
        Me._optdir_0.Name = "_optdir_0"
        Me.COBISResourceProvider.SetResourceID(Me._optdir_0, "501156")
        Me._optdir_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optdir_0.Size = New System.Drawing.Size(149, 16)
        Me._optdir_0.TabIndex = 34
        Me._optdir_0.TabStop = True
        Me._optdir_0.Text = "*Estado de Cuenta"
        Me._optdir_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optdir_0, "")
        '
        '_optdir_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optdir_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optdir_1, False)
        Me._optdir_1.BackColor = System.Drawing.Color.Transparent
        Me._optdir_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optdir_1, "Default")
        Me._optdir_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optdir_1.ForeColor = System.Drawing.Color.Navy
        Me._optdir_1.Location = New System.Drawing.Point(26, 344)
        Me._optdir_1.Name = "_optdir_1"
        Me.COBISResourceProvider.SetResourceID(Me._optdir_1, "501157")
        Me._optdir_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optdir_1.Size = New System.Drawing.Size(149, 16)
        Me._optdir_1.TabIndex = 33
        Me._optdir_1.TabStop = True
        Me._optdir_1.Text = "*Cheques Devueltos"
        Me._optdir_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optdir_1, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Enabled = False
        Me._txtCampo_6.Location = New System.Drawing.Point(530, 72)
        Me._txtCampo_6.MaxLength = 64
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(39, 20)
        Me._txtCampo_6.TabIndex = 31
        Me._txtCampo_6.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(316, 247)
        Me._txtCampo_5.MaxLength = 2
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(28, 20)
        Me._txtCampo_5.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me._optcausa_1)
        Me.Frame1.Controls.Add(Me._optcausa_0)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(316, 219)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(269, 25)
        Me.Frame1.TabIndex = 12
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        '_optcausa_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optcausa_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optcausa_1, False)
        Me._optcausa_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optcausa_1, "Default")
        Me._optcausa_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optcausa_1.ForeColor = System.Drawing.Color.Black
        Me._optcausa_1.Location = New System.Drawing.Point(179, 6)
        Me._optcausa_1.Name = "_optcausa_1"
        Me.COBISResourceProvider.SetResourceID(Me._optcausa_1, "501965")
        Me._optcausa_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optcausa_1.Size = New System.Drawing.Size(64, 18)
        Me._optcausa_1.TabIndex = 6
        Me._optcausa_1.Text = "*Canje"
        Me._optcausa_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optcausa_1, "")
        '
        '_optcausa_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optcausa_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optcausa_0, False)
        Me._optcausa_0.BackColor = System.Drawing.Color.Transparent
        Me._optcausa_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optcausa_0, "Default")
        Me._optcausa_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optcausa_0.ForeColor = System.Drawing.Color.Black
        Me._optcausa_0.Location = New System.Drawing.Point(35, 6)
        Me._optcausa_0.Name = "_optcausa_0"
        Me.COBISResourceProvider.SetResourceID(Me._optcausa_0, "501947")
        Me._optcausa_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optcausa_0.Size = New System.Drawing.Size(118, 18)
        Me._optcausa_0.TabIndex = 5
        Me._optcausa_0.TabStop = True
        Me._optcausa_0.Text = "*Lev. Anulación"
        Me._optcausa_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optcausa_0, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(135, 219)
        Me._txtCampo_4.MaxLength = 8
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(119, 20)
        Me._txtCampo_4.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(677, 181)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 9
        Me._cmdBoton_3.Tag = "6335"
        Me._cmdBoton_3.Text = "*&Imprimir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(135, 270)
        Me._txtCampo_3.MaxLength = 2
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_3.TabIndex = 2
        Me._txtCampo_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(402, 330)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(128, 20)
        Me._txtCampo_1.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        'chkFuncionario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkFuncionario, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkFuncionario, False)
        Me.chkFuncionario.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkFuncionario, "Default")
        Me.chkFuncionario.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkFuncionario.Enabled = False
        Me.chkFuncionario.ForeColor = System.Drawing.Color.Navy
        Me.chkFuncionario.Location = New System.Drawing.Point(135, 173)
        Me.chkFuncionario.Name = "chkFuncionario"
        Me.COBISResourceProvider.SetResourceID(Me.chkFuncionario, "501275")
        Me.chkFuncionario.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkFuncionario.Size = New System.Drawing.Size(185, 20)
        Me.chkFuncionario.TabIndex = 14
        Me.chkFuncionario.Text = "*Cuenta de funcionario"
        Me.chkFuncionario.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkFuncionario, "")
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
        Me.grdPropietarios.Location = New System.Drawing.Point(6, 16)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(563, 83)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 15
        Me.grdPropietarios.TabStop = False
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(158, 10)
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(677, 232)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 8
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(677, 283)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 10
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(677, 334)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 11
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Enabled = False
        Me._txtCampo_0.Location = New System.Drawing.Point(135, 150)
        Me._txtCampo_0.MaxLength = 64
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(450, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Enabled = False
        Me._txtCampo_2.Location = New System.Drawing.Point(135, 196)
        Me._txtCampo_2.MaxLength = 2
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_2.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(677, 27)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 48
        Me._cmdBoton_4.Text = "*Bene&ficiarios"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(206, 374)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(379, 28)
        Me.lbldesalianza.TabIndex = 51
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Location = New System.Drawing.Point(135, 374)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(65, 20)
        Me.Lblalianza.TabIndex = 50
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(10, 374)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2210")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(69, 20)
        Me.Label5.TabIndex = 49
        Me.Label5.Text = "*Alianza:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        '_lblEtiqueta_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_19, False)
        Me._lblEtiqueta_19.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_19, "Default")
        Me._lblEtiqueta_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_19.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_19.Location = New System.Drawing.Point(402, 314)
        Me._lblEtiqueta_19.Name = "_lblEtiqueta_19"
        Me._lblEtiqueta_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_19.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_19.TabIndex = 37
        Me._lblEtiqueta_19.Text = "*Código de dirección:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_19, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(402, 352)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(183, 19)
        Me._lblDescripcion_14.TabIndex = 36
        Me._lblDescripcion_14.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(402, 352)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(183, 19)
        Me._lblDescripcion_4.TabIndex = 32
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(34, 120)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(124, 20)
        Me._lblEtiqueta_8.TabIndex = 30
        Me._lblEtiqueta_8.Text = "Nom.Libreta Cotitular:"
        Me._lblEtiqueta_8.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(345, 247)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(240, 20)
        Me._lblDescripcion_0.TabIndex = 29
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(264, 247)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "5155")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(56, 20)
        Me._lblEtiqueta_7.TabIndex = 28
        Me._lblEtiqueta_7.Text = "*Causa:"
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 219)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "501966")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(125, 20)
        Me._lblEtiqueta_6.TabIndex = 27
        Me._lblEtiqueta_6.Text = "*Número de Libreta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(310, 10)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "501255")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(191, 20)
        Me._lblEtiqueta_10.TabIndex = 26
        Me._lblEtiqueta_10.Text = "*Fecha de corte estado cuenta:"
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
        Me._lblDescripcion_3.Location = New System.Drawing.Point(507, 10)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(78, 20)
        Me._lblDescripcion_3.TabIndex = 25
        Me._lblDescripcion_3.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 270)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "5176")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(125, 20)
        Me._lblEtiqueta_5.TabIndex = 16
        Me._lblEtiqueta_5.Text = "*Producto Bancario:"
        Me._lblEtiqueta_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(180, 270)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(405, 20)
        Me._lblDescripcion_2.TabIndex = 17
        Me._lblDescripcion_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 303)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "501253")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(86, 20)
        Me._lblEtiqueta_2.TabIndex = 19
        Me._lblEtiqueta_2.Text = "*Dirección:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(402, 314)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "501172")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(128, 20)
        Me._lblEtiqueta_12.TabIndex = 24
        Me._lblEtiqueta_12.Text = "*Código de dirección:"
        Me._lblEtiqueta_12.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(148, 20)
        Me._lblEtiqueta_0.TabIndex = 23
        Me._lblEtiqueta_0.Text = "*No. de cuenta ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(180, 196)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(405, 20)
        Me._lblDescripcion_1.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 196)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501281")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(125, 20)
        Me._lblEtiqueta_1.TabIndex = 21
        Me._lblEtiqueta_1.Text = "*Ciclo de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 150)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "500585")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(125, 20)
        Me._lblEtiqueta_4.TabIndex = 20
        Me._lblEtiqueta_4.Text = "*Nombre de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me.frmDirecciones)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_4)
        Me.PFormas.Controls.Add(Me.Frame1dv)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._txtCampo_13)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._optdir_0)
        Me.PFormas.Controls.Add(Me._optdir_1)
        Me.PFormas.Controls.Add(Me._txtCampo_6)
        Me.PFormas.Controls.Add(Me._txtCampo_5)
        Me.PFormas.Controls.Add(Me.Frame1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_12)
        Me.PFormas.Controls.Add(Me._txtCampo_4)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me._txtCampo_3)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_3)
        Me.PFormas.Controls.Add(Me.chkFuncionario)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_10)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_7)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_8)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._lblDescripcion_4)
        Me.PFormas.Controls.Add(Me._txtCampo_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_14)
        Me.PFormas.Controls.Add(Me._txtCampo_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_19)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me.Label5)
        Me.PFormas.Controls.Add(Me.lbldesalianza)
        Me.PFormas.Controls.Add(Me.Lblalianza)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(595, 411)
        Me.PFormas.TabIndex = 55
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
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 33)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "501079")
        Me.GroupBox1.Size = New System.Drawing.Size(575, 107)
        Me.GroupBox1.TabIndex = 53
        Me.GroupBox1.Text = "*Lista de Propietarios:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBeneficiarios, Me.TSBImprimir, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(610, 25)
        Me.TSBBotones.TabIndex = 56
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBBeneficiarios
        '
        Me.TSBBeneficiarios.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBBeneficiarios.Image = CType(resources.GetObject("TSBBeneficiarios.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBeneficiarios, "2071")
        Me.TSBBeneficiarios.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBeneficiarios.Name = "TSBBeneficiarios"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBeneficiarios, "501283")
        Me.TSBBeneficiarios.Size = New System.Drawing.Size(99, 22)
        Me.TSBBeneficiarios.Text = "*Bene&ficiarios"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
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
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
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
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
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
        'FTran205Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(133, 101)
        Me.Name = "FTran205Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(610, 450)
        Me.Tag = "3101"
        Me.Text = "*Actualización General de Cuentas de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmDirecciones, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmDirecciones.ResumeLayout(False)
        CType(Me.Frame1dv, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1dv.ResumeLayout(False)
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBBotones.ResumeLayout(False)
        Me.TSBBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(13) = _txtCampo_13
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(2) = _txtCampo_2
    End Sub
    Sub Initializeoptdir()
        Me.optdir(0) = _optdir_0
        Me.optdir(1) = _optdir_1
    End Sub
    Sub Initializeoptcausa()
        Me.optcausa(1) = _optcausa_1
        Me.optcausa(0) = _optcausa_0
    End Sub
    Sub InitializeoptDirecciondv()
        Me.optDirecciondv(3) = _optDirecciondv_3
        Me.optDirecciondv(2) = _optDirecciondv_2
        Me.optDirecciondv(1) = _optDirecciondv_1
        Me.optDirecciondv(0) = _optDirecciondv_0
    End Sub
    Sub InitializeoptDireccion()
        Me.optDireccion(0) = _optDireccion_0
        Me.optDireccion(1) = _optDireccion_1
        Me.optDireccion(2) = _optDireccion_2
        Me.optDireccion(3) = _optDireccion_3
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(19) = _lblEtiqueta_19
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        ' Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(4) = _lblEtiqueta_4
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(2) = _Line1_2
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(0) = _Line1_0
    'End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBeneficiarios As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


