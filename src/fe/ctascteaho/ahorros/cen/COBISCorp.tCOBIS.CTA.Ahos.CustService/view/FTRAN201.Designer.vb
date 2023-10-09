'Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FTran201Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        Initializeoptdir()
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
    Private WithEvents _txtCampo_21 As System.Windows.Forms.TextBox

    Private WithEvents _txtCampo_14 As System.Windows.Forms.TextBox
    Public WithEvents chkFuncionario As System.Windows.Forms.CheckBox
    Private WithEvents _txtCampo_18 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_19 As System.Windows.Forms.TextBox
    Public WithEvents cmbenvioec As System.Windows.Forms.ComboBox
    Private WithEvents _optdir_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optdir_0 As System.Windows.Forms.RadioButton
    Private WithEvents _txtCampo_12 As System.Windows.Forms.TextBox
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _txtCampo_11 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_9 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_8 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_10 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Public WithEvents Mskvalor As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_13 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_9 As System.Windows.Forms.Button
    Private WithEvents _optDireccion_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_3 As System.Windows.Forms.RadioButton
    Private WithEvents _optDireccion_0 As System.Windows.Forms.RadioButton
    Public WithEvents frmDirecciones As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optDirecciondv_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optDirecciondv_3 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1dv As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_22 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_20 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_20 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_25 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_18 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_22 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_13 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_15 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(9) As System.Windows.Forms.Button
    Public lblDescripcion(22) As System.Windows.Forms.Label
    Public lblEtiqueta(25) As System.Windows.Forms.Label
    Public optDireccion(3) As System.Windows.Forms.RadioButton
    Public optDirecciondv(3) As System.Windows.Forms.RadioButton
    Public optdir(1) As System.Windows.Forms.RadioButton
    Public txtCampo(21) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran201Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_21 = New System.Windows.Forms.TextBox()
        Me._txtCampo_14 = New System.Windows.Forms.TextBox()
        Me.chkFuncionario = New System.Windows.Forms.CheckBox()
        Me._txtCampo_18 = New System.Windows.Forms.TextBox()
        Me._txtCampo_19 = New System.Windows.Forms.TextBox()
        Me.cmbenvioec = New System.Windows.Forms.ComboBox()
        Me._optdir_1 = New System.Windows.Forms.RadioButton()
        Me._optdir_0 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_12 = New System.Windows.Forms.TextBox()
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._txtCampo_11 = New System.Windows.Forms.TextBox()
        Me._txtCampo_9 = New System.Windows.Forms.TextBox()
        Me._txtCampo_8 = New System.Windows.Forms.TextBox()
        Me._txtCampo_10 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me.Mskvalor = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_13 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_9 = New System.Windows.Forms.Button()
        Me.frmDirecciones = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optDireccion_3 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_2 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_0 = New System.Windows.Forms.RadioButton()
        Me._optDireccion_1 = New System.Windows.Forms.RadioButton()
        Me.Frame1dv = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optDirecciondv_1 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_2 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_0 = New System.Windows.Forms.RadioButton()
        Me._optDirecciondv_3 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_20 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_16 = New System.Windows.Forms.Label()
        Me._lblDescripcion_20 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_25 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_18 = New System.Windows.Forms.Label()
        Me._lblDescripcion_14 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_22 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._lblDescripcion_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_11 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_15 = New System.Windows.Forms.Label()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_22 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox5 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me.UltraGroupBox4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_19 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_15 = New System.Windows.Forms.TextBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBAnadir = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBPerfil = New System.Windows.Forms.ToolStripButton()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCanales = New System.Windows.Forms.ToolStripButton()
        Me.TSBContrato = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.frmDirecciones, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmDirecciones.SuspendLayout()
        CType(Me.Frame1dv, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox5.SuspendLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox3.SuspendLayout()
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox4.SuspendLayout()
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
        '_txtCampo_21
        '
        Me._txtCampo_21.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_21, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_21, False)
        Me._txtCampo_21.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_21, "Default")
        Me._txtCampo_21.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_21.Location = New System.Drawing.Point(152, 7)
        Me._txtCampo_21.MaxLength = 1
        Me._txtCampo_21.Name = "_txtCampo_21"
        Me._txtCampo_21.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_21.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_21.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_21, "")
        '
        '_txtCampo_14
        '
        Me._txtCampo_14.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_14, False)
        Me._txtCampo_14.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_14, "Default")
        Me._txtCampo_14.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_14.Location = New System.Drawing.Point(150, 7)
        Me._txtCampo_14.MaxLength = 9
        Me._txtCampo_14.Name = "_txtCampo_14"
        Me._txtCampo_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_14.Size = New System.Drawing.Size(78, 20)
        Me._txtCampo_14.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_14, "")
        '
        'chkFuncionario
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkFuncionario, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkFuncionario, False)
        Me.chkFuncionario.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkFuncionario, "Default")
        Me.chkFuncionario.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkFuncionario.Enabled = False
        Me.chkFuncionario.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkFuncionario.ForeColor = System.Drawing.Color.Navy
        Me.chkFuncionario.Location = New System.Drawing.Point(88, 126)
        Me.chkFuncionario.Name = "chkFuncionario"
        Me.COBISResourceProvider.SetResourceID(Me.chkFuncionario, "501275")
        Me.chkFuncionario.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkFuncionario.Size = New System.Drawing.Size(134, 15)
        Me.chkFuncionario.TabIndex = 21
        Me.chkFuncionario.Text = "*Cuenta de funcionario"
        Me.chkFuncionario.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkFuncionario, "")
        '
        '_txtCampo_18
        '
        Me._txtCampo_18.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_18, False)
        Me._txtCampo_18.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_18, "Default")
        Me._txtCampo_18.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_18.Location = New System.Drawing.Point(150, 122)
        Me._txtCampo_18.MaxLength = 1
        Me._txtCampo_18.Name = "_txtCampo_18"
        Me._txtCampo_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_18.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_18.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_18, "")
        '
        '_txtCampo_19
        '
        Me._txtCampo_19.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_19, False)
        Me._txtCampo_19.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_19, "Default")
        Me._txtCampo_19.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_19.Location = New System.Drawing.Point(88, 76)
        Me._txtCampo_19.MaxLength = 1
        Me._txtCampo_19.Name = "_txtCampo_19"
        Me._txtCampo_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_19.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_19.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_19, "")
        '
        'cmbenvioec
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbenvioec, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbenvioec, False)
        Me.cmbenvioec.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbenvioec, "Default")
        Me.cmbenvioec.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbenvioec.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbenvioec.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbenvioec.Location = New System.Drawing.Point(185, 146)
        Me.cmbenvioec.Name = "cmbenvioec"
        Me.cmbenvioec.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbenvioec.Size = New System.Drawing.Size(44, 21)
        Me.cmbenvioec.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbenvioec, "")
        '
        '_optdir_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optdir_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optdir_1, False)
        Me._optdir_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optdir_1, "Default")
        Me._optdir_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optdir_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optdir_1.ForeColor = System.Drawing.Color.Navy
        Me._optdir_1.Location = New System.Drawing.Point(10, 31)
        Me._optdir_1.Name = "_optdir_1"
        Me.COBISResourceProvider.SetResourceID(Me._optdir_1, "501157")
        Me._optdir_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optdir_1.Size = New System.Drawing.Size(148, 17)
        Me._optdir_1.TabIndex = 24
        Me._optdir_1.TabStop = True
        Me._optdir_1.Text = "*Cheques Devueltos"
        Me._optdir_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optdir_1, "")
        '
        '_optdir_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optdir_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optdir_0, False)
        Me._optdir_0.BackColor = System.Drawing.Color.Transparent
        Me._optdir_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optdir_0, "Default")
        Me._optdir_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optdir_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optdir_0.ForeColor = System.Drawing.Color.Navy
        Me._optdir_0.Location = New System.Drawing.Point(10, 31)
        Me._optdir_0.Name = "_optdir_0"
        Me._optdir_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optdir_0.Size = New System.Drawing.Size(148, 17)
        Me._optdir_0.TabIndex = 25
        Me._optdir_0.TabStop = True
        Me._optdir_0.Text = "*Estado de Cuenta"
        Me._optdir_0.UseVisualStyleBackColor = True
        Me._optdir_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optdir_0, "")
        '
        '_txtCampo_12
        '
        Me._txtCampo_12.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_12, False)
        Me._txtCampo_12.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_12, "Default")
        Me._txtCampo_12.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_12.Location = New System.Drawing.Point(88, 99)
        Me._txtCampo_12.MaxLength = 40
        Me._txtCampo_12.Multiline = True
        Me._txtCampo_12.Name = "_txtCampo_12"
        Me._txtCampo_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_12.Size = New System.Drawing.Size(187, 20)
        Me._txtCampo_12.TabIndex = 20
        Me._txtCampo_12.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_12, "")
        '
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(451, 19)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 81
        Me.rptReporte.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
        '
        '_txtCampo_11
        '
        Me._txtCampo_11.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_11, False)
        Me._txtCampo_11.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_11, "Default")
        Me._txtCampo_11.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_11.Location = New System.Drawing.Point(407, 488)
        Me._txtCampo_11.MaxLength = 8
        Me._txtCampo_11.Name = "_txtCampo_11"
        Me._txtCampo_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_11.Size = New System.Drawing.Size(17, 20)
        Me._txtCampo_11.TabIndex = 99
        Me._txtCampo_11.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_11, "")
        '
        '_txtCampo_9
        '
        Me._txtCampo_9.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_9, False)
        Me._txtCampo_9.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_9, "Default")
        Me._txtCampo_9.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_9.Location = New System.Drawing.Point(150, 30)
        Me._txtCampo_9.MaxLength = 2
        Me._txtCampo_9.Name = "_txtCampo_9"
        Me._txtCampo_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_9.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_9.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_9, "")
        '
        '_txtCampo_8
        '
        Me._txtCampo_8.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_8, False)
        Me._txtCampo_8.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_8, "Default")
        Me._txtCampo_8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_8.Location = New System.Drawing.Point(150, 7)
        Me._txtCampo_8.MaxLength = 2
        Me._txtCampo_8.Name = "_txtCampo_8"
        Me._txtCampo_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_8.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_8.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_8, "")
        '
        '_txtCampo_10
        '
        Me._txtCampo_10.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_10, False)
        Me._txtCampo_10.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_10, "Default")
        Me._txtCampo_10.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_10.Location = New System.Drawing.Point(150, 99)
        Me._txtCampo_10.MaxLength = 2
        Me._txtCampo_10.Name = "_txtCampo_10"
        Me._txtCampo_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_10.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_10.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_10, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-713, 433)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 99
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Salir"
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-713, 382)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 99
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Limpiar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-699, 273)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 99
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Transmitir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(150, 76)
        Me._txtCampo_5.MaxLength = 2
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_5.TabIndex = 11
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
        Me._txtCampo_4.Location = New System.Drawing.Point(150, 53)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_4.TabIndex = 10
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
        Me._txtCampo_2.Enabled = False
        Me._txtCampo_2.Location = New System.Drawing.Point(150, 8)
        Me._txtCampo_2.MaxLength = 64
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(480, 20)
        Me._txtCampo_2.TabIndex = 99
        Me._txtCampo_2.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(505, 53)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(25, 20)
        Me._txtCampo_1.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(150, 53)
        Me._txtCampo_0.MaxLength = 8
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(58, 20)
        Me._txtCampo_0.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-713, 70)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(60, 26)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 99
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*Añadir"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-713, 96)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(60, 26)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 99
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*Eliminar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me.grdPropietarios.Size = New System.Drawing.Size(634, 55)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 6
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Location = New System.Drawing.Point(88, 7)
        Me._txtCampo_6.MaxLength = 2
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_6.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Location = New System.Drawing.Point(88, 30)
        Me._txtCampo_7.MaxLength = 3
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_7.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        'Mskvalor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Mskvalor, False)
        Me.COBISViewResizer.SetAutoResize(Me.Mskvalor, False)
        Me.COBISStyleProvider.SetControlStyle(Me.Mskvalor, "Default")
        Me.Mskvalor.Length = CType(64, Short)
        Me.Mskvalor.Location = New System.Drawing.Point(430, 488)
        Me.Mskvalor.MaxReal = 3.402823E+38!
        Me.Mskvalor.MinReal = -3.402823E+38!
        Me.Mskvalor.Name = "Mskvalor"
        Me.Mskvalor.Size = New System.Drawing.Size(15, 20)
        Me.Mskvalor.TabIndex = 26
        Me.Mskvalor.TabStop = False
        Me.Mskvalor.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Mskvalor, "")
        '
        '_txtCampo_13
        '
        Me._txtCampo_13.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_13, False)
        Me._txtCampo_13.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_13, "Default")
        Me._txtCampo_13.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_13.Location = New System.Drawing.Point(150, 51)
        Me._txtCampo_13.MaxLength = 4
        Me._txtCampo_13.Name = "_txtCampo_13"
        Me._txtCampo_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_13.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_13.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_13, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(150, 51)
        Me._txtCampo_3.MaxLength = 4
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(45, 20)
        Me._txtCampo_3.TabIndex = 99
        Me._txtCampo_3.TabStop = False
        Me._txtCampo_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
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
        Me._cmdBoton_6.Enabled = False
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-713, 123)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(60, 26)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 99
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Text = "*Perfil Cta."
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me._cmdBoton_6.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        '_cmdBoton_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_9, False)
        Me._cmdBoton_9.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_9, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_9, True)
        Me._cmdBoton_9.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_9, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_9, Nothing)
        Me._cmdBoton_9.Enabled = False
        Me._cmdBoton_9.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_9.Location = New System.Drawing.Point(-713, 279)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_9, System.Drawing.Color.Silver)
        Me._cmdBoton_9.Name = "_cmdBoton_9"
        Me._cmdBoton_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_9.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_9, 1)
        Me._cmdBoton_9.TabIndex = 99
        Me._cmdBoton_9.TabStop = False
        Me._cmdBoton_9.Tag = "6335"
        Me._cmdBoton_9.Text = "*&Contrato"
        Me._cmdBoton_9.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_9.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_9, "")
        '
        'frmDirecciones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmDirecciones, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmDirecciones, False)
        Me.frmDirecciones.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmDirecciones.Controls.Add(Me._optDireccion_3)
        Me.COBISStyleProvider.SetControlStyle(Me.frmDirecciones, "Default")
        Me.frmDirecciones.ForeColor = System.Drawing.Color.Navy
        Me.frmDirecciones.Location = New System.Drawing.Point(-728, 329)
        Me.frmDirecciones.Name = "frmDirecciones"
        Me.frmDirecciones.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmDirecciones.Size = New System.Drawing.Size(121, 18)
        Me.frmDirecciones.TabIndex = 33
        Me.frmDirecciones.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.frmDirecciones.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmDirecciones, "")
        '
        '_optDireccion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_3, False)
        Me._optDireccion_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_3, "Default")
        Me._optDireccion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_3.Enabled = False
        Me._optDireccion_3.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_3.Location = New System.Drawing.Point(2, 24)
        Me._optDireccion_3.Name = "_optDireccion_3"
        Me._optDireccion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_3.Size = New System.Drawing.Size(170, 13)
        Me._optDireccion_3.TabIndex = 32
        Me._optDireccion_3.Text = "Retener en casillero del banco"
        Me._optDireccion_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_3, "")
        '
        '_optDireccion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_2, False)
        Me._optDireccion_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_2, "Default")
        Me._optDireccion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_2.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_2.Location = New System.Drawing.Point(-730, 192)
        Me._optDireccion_2.Name = "_optDireccion_2"
        Me._optDireccion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_2.Size = New System.Drawing.Size(170, 13)
        Me._optDireccion_2.TabIndex = 19
        Me._optDireccion_2.Text = "Retener en sucursal del banco"
        Me._optDireccion_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_2, "")
        '
        '_optDireccion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_0, False)
        Me._optDireccion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_0, "Default")
        Me._optDireccion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_0.Enabled = False
        Me._optDireccion_0.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_0.Location = New System.Drawing.Point(-728, 212)
        Me._optDireccion_0.Name = "_optDireccion_0"
        Me._optDireccion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_0.Size = New System.Drawing.Size(170, 13)
        Me._optDireccion_0.TabIndex = 14
        Me._optDireccion_0.Text = "Enviar a dirección del cliente"
        Me._optDireccion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_0, "")
        '
        '_optDireccion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDireccion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDireccion_1, False)
        Me._optDireccion_1.BackColor = System.Drawing.Color.Transparent
        Me._optDireccion_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optDireccion_1, "Default")
        Me._optDireccion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDireccion_1.ForeColor = System.Drawing.Color.Navy
        Me._optDireccion_1.Location = New System.Drawing.Point(-730, 310)
        Me._optDireccion_1.Name = "_optDireccion_1"
        Me._optDireccion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDireccion_1.Size = New System.Drawing.Size(170, 13)
        Me._optDireccion_1.TabIndex = 31
        Me._optDireccion_1.TabStop = True
        Me._optDireccion_1.Text = "Enviar a casilla postal del cliente"
        Me._optDireccion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDireccion_1, "")
        '
        'Frame1dv
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1dv, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1dv, False)
        Me.Frame1dv.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1dv, "Default")
        Me.Frame1dv.ForeColor = System.Drawing.Color.Navy
        Me.Frame1dv.Location = New System.Drawing.Point(-732, 353)
        Me.Frame1dv.Name = "Frame1dv"
        Me.Frame1dv.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1dv.Size = New System.Drawing.Size(101, 40)
        Me.Frame1dv.TabIndex = 66
        Me.Frame1dv.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.Frame1dv.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1dv, "")
        '
        '_optDirecciondv_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_1, False)
        Me._optDirecciondv_1.BackColor = System.Drawing.Color.Transparent
        Me._optDirecciondv_1.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_1, "Default")
        Me._optDirecciondv_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_1.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_1.Location = New System.Drawing.Point(-730, 291)
        Me._optDirecciondv_1.Name = "_optDirecciondv_1"
        Me._optDirecciondv_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_1.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_1.TabIndex = 20
        Me._optDirecciondv_1.TabStop = True
        Me._optDirecciondv_1.Text = "Enviar a casilla postal del cliente"
        Me._optDirecciondv_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_1, "")
        '
        '_optDirecciondv_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_2, False)
        Me._optDirecciondv_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_2, "Default")
        Me._optDirecciondv_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_2.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_2.Location = New System.Drawing.Point(-730, 253)
        Me._optDirecciondv_2.Name = "_optDirecciondv_2"
        Me._optDirecciondv_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_2.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_2.TabIndex = 67
        Me._optDirecciondv_2.Text = "Retener en sucursal del banco"
        Me._optDirecciondv_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_2, "")
        '
        '_optDirecciondv_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_0, False)
        Me._optDirecciondv_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_0, "Default")
        Me._optDirecciondv_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_0.Enabled = False
        Me._optDirecciondv_0.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_0.Location = New System.Drawing.Point(-730, 272)
        Me._optDirecciondv_0.Name = "_optDirecciondv_0"
        Me._optDirecciondv_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_0.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_0.TabIndex = 68
        Me._optDirecciondv_0.Text = "Enviar a dirección del cliente"
        Me._optDirecciondv_0.UseVisualStyleBackColor = True
        Me._optDirecciondv_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_0, "")
        '
        '_optDirecciondv_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optDirecciondv_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optDirecciondv_3, False)
        Me._optDirecciondv_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optDirecciondv_3, "Default")
        Me._optDirecciondv_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optDirecciondv_3.Enabled = False
        Me._optDirecciondv_3.ForeColor = System.Drawing.Color.Navy
        Me._optDirecciondv_3.Location = New System.Drawing.Point(-728, 234)
        Me._optDirecciondv_3.Name = "_optDirecciondv_3"
        Me._optDirecciondv_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optDirecciondv_3.Size = New System.Drawing.Size(170, 13)
        Me._optDirecciondv_3.TabIndex = 21
        Me._optDirecciondv_3.Text = "Retener en casillero del banco"
        Me._optDirecciondv_3.UseVisualStyleBackColor = True
        Me._optDirecciondv_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optDirecciondv_3, "")
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(-713, 163)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(60, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 99
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*&Buscar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me._cmdBoton_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_7.Location = New System.Drawing.Point(-713, 205)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 99
        Me._cmdBoton_7.TabStop = False
        Me._cmdBoton_7.Text = "*C&anales"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Enabled = False
        Me.Lblalianza.Location = New System.Drawing.Point(152, 74)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(42, 20)
        Me.Lblalianza.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(7, 77)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2210")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(139, 20)
        Me.Label5.TabIndex = 99
        Me.Label5.Text = "*Alianza:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        '_lblEtiqueta_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_20, False)
        Me._lblEtiqueta_20.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_20, "Default")
        Me._lblEtiqueta_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_20.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_20.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_20.Location = New System.Drawing.Point(5, 148)
        Me._lblEtiqueta_20.Name = "_lblEtiqueta_20"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_20, "5233")
        Me._lblEtiqueta_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_20.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_20.TabIndex = 99
        Me._lblEtiqueta_20.Text = "*Fideicomiso:"
        Me._lblEtiqueta_20.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_20, "")
        '
        '_lblEtiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_16, False)
        Me._lblEtiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_16, "Default")
        Me._lblEtiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_16.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_16.Location = New System.Drawing.Point(4, 9)
        Me._lblEtiqueta_16.Name = "_lblEtiqueta_16"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_16, "501072")
        Me._lblEtiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_16.Size = New System.Drawing.Size(146, 13)
        Me._lblEtiqueta_16.TabIndex = 99
        Me._lblEtiqueta_16.Text = "*No. de Solicitud:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_16, "")
        '
        '_lblDescripcion_20
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_20, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_20, False)
        Me._lblDescripcion_20.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_20.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_20, "Default")
        Me._lblDescripcion_20.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_20.Location = New System.Drawing.Point(198, 122)
        Me._lblDescripcion_20.Name = "_lblDescripcion_20"
        Me._lblDescripcion_20.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_20.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_20.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_20, "")
        '
        '_lblEtiqueta_25
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_25, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_25, False)
        Me._lblEtiqueta_25.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_25, "Default")
        Me._lblEtiqueta_25.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_25.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_25.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_25.Location = New System.Drawing.Point(5, 125)
        Me._lblEtiqueta_25.Name = "_lblEtiqueta_25"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_25, "5151")
        Me._lblEtiqueta_25.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_25.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_25.TabIndex = 99
        Me._lblEtiqueta_25.Text = "*Titularidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_25, "")
        '
        '_lblEtiqueta_18
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_18, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_18, False)
        Me._lblEtiqueta_18.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_18, "Default")
        Me._lblEtiqueta_18.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_18.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_18.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_18.Location = New System.Drawing.Point(6, 78)
        Me._lblEtiqueta_18.Name = "_lblEtiqueta_18"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_18, "501919")
        Me._lblEtiqueta_18.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_18.Size = New System.Drawing.Size(76, 15)
        Me._lblEtiqueta_18.TabIndex = 99
        Me._lblEtiqueta_18.Text = "*Cl. Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_18, "")
        '
        '_lblDescripcion_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_14, False)
        Me._lblDescripcion_14.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_14.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_14, "Default")
        Me._lblDescripcion_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_14.Location = New System.Drawing.Point(136, 76)
        Me._lblDescripcion_14.Name = "_lblDescripcion_14"
        Me._lblDescripcion_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_14.Size = New System.Drawing.Size(139, 19)
        Me._lblDescripcion_14.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_14, "")
        '
        '_lblEtiqueta_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_22, False)
        Me._lblEtiqueta_22.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_22, "Default")
        Me._lblEtiqueta_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_22.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_22.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_22.Location = New System.Drawing.Point(85, 149)
        Me._lblEtiqueta_22.Name = "_lblEtiqueta_22"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_22, "501920")
        Me._lblEtiqueta_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_22.Size = New System.Drawing.Size(94, 14)
        Me._lblEtiqueta_22.TabIndex = 99
        Me._lblEtiqueta_22.Text = "*Generar Est.Cta.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_22, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(5, 33)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "501922")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_14.TabIndex = 99
        Me._lblEtiqueta_14.Text = "*Origen cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_lblDescripcion_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_12, False)
        Me._lblDescripcion_12.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_12.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_12, "Default")
        Me._lblDescripcion_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_12.Location = New System.Drawing.Point(198, 30)
        Me._lblDescripcion_12.Name = "_lblDescripcion_12"
        Me._lblDescripcion_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_12.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_12.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_12, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(456, 57)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "501129")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(43, 12)
        Me._lblEtiqueta_13.TabIndex = 99
        Me._lblEtiqueta_13.Text = "*Rol:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(4, 56)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "500163")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(146, 13)
        Me._lblEtiqueta_11.TabIndex = 99
        Me._lblEtiqueta_11.Text = "*Cliente:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(5, 10)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "5176")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_8.TabIndex = 99
        Me._lblEtiqueta_8.Text = "*Producto Bancario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(7, 10)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "501253")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(139, 14)
        Me._lblEtiqueta_2.TabIndex = 99
        Me._lblEtiqueta_2.Text = "*Dirección:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_13, False)
        Me._lblDescripcion_13.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_13.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_13, "Default")
        Me._lblDescripcion_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_13.Location = New System.Drawing.Point(198, 99)
        Me._lblDescripcion_13.Name = "_lblDescripcion_13"
        Me._lblDescripcion_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_13.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_13.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_13, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(4, 32)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(146, 13)
        Me._lblEtiqueta_0.TabIndex = 99
        Me._lblEtiqueta_0.Text = "*No. de Cuenta Ahorros:"
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
        Me._lblDescripcion_0.Location = New System.Drawing.Point(150, 30)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(117, 20)
        Me._lblDescripcion_0.TabIndex = 99
        Me._lblDescripcion_0.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(210, 53)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(88, 20)
        Me._lblDescripcion_2.TabIndex = 99
        Me._lblDescripcion_2.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(319, 53)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(128, 20)
        Me._lblDescripcion_4.TabIndex = 99
        Me._lblDescripcion_4.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(536, 53)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(94, 20)
        Me._lblDescripcion_5.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(7, 11)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5017")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(123, 12)
        Me._lblEtiqueta_1.TabIndex = 99
        Me._lblEtiqueta_1.Text = "*Nom. de la Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(5, 56)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "501179")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_3.TabIndex = 99
        Me._lblEtiqueta_3.Text = "*Oficial de cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(5, 79)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "501925")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_4.TabIndex = 99
        Me._lblEtiqueta_4.Text = "*Tipo de promedio:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(6, 33)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "500786")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(76, 15)
        Me._lblEtiqueta_5.TabIndex = 99
        Me._lblEtiqueta_5.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(6, 11)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500861")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(76, 16)
        Me._lblEtiqueta_6.TabIndex = 99
        Me._lblEtiqueta_6.Text = "*Ciclo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(198, 53)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_7.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblDescripcion_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(198, 76)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_8.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblDescripcion_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(136, 7)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(139, 20)
        Me._lblDescripcion_9.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_11, False)
        Me._lblDescripcion_11.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_11.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_11, "Default")
        Me._lblDescripcion_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_11.Location = New System.Drawing.Point(198, 7)
        Me._lblDescripcion_11.Name = "_lblDescripcion_11"
        Me._lblDescripcion_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_11.Size = New System.Drawing.Size(143, 20)
        Me._lblDescripcion_11.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_11, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(298, 53)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(20, 20)
        Me._lblDescripcion_3.TabIndex = 99
        Me._lblDescripcion_3.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(5, 102)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "501926")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_7.TabIndex = 99
        Me._lblEtiqueta_7.Text = "*Tipo capitalización:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(338, 32)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "501255")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(192, 14)
        Me._lblEtiqueta_10.TabIndex = 99
        Me._lblEtiqueta_10.Text = "*Fecha de corte estado cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(536, 29)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(94, 20)
        Me._lblDescripcion_1.TabIndex = 99
        Me._lblDescripcion_1.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(136, 30)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(139, 20)
        Me._lblDescripcion_10.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblDescripcion_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_15, False)
        Me._lblDescripcion_15.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_15.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_15, "Default")
        Me._lblDescripcion_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_15.Location = New System.Drawing.Point(200, 51)
        Me._lblDescripcion_15.Name = "_lblDescripcion_15"
        Me._lblDescripcion_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_15.Size = New System.Drawing.Size(430, 20)
        Me._lblDescripcion_15.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_15, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(200, 74)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(430, 20)
        Me.lbldesalianza.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        '_lblDescripcion_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(200, 51)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(430, 20)
        Me._lblDescripcion_6.TabIndex = 99
        Me._lblDescripcion_6.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblDescripcion_22
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_22, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_22, False)
        Me._lblDescripcion_22.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_22.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_22, "Default")
        Me._lblDescripcion_22.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_22.Location = New System.Drawing.Point(200, 7)
        Me._lblDescripcion_22.Name = "_lblDescripcion_22"
        Me._lblDescripcion_22.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_22.Size = New System.Drawing.Size(430, 20)
        Me._lblDescripcion_22.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_22, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(6, 102)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_15, "5152")
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(76, 16)
        Me._lblEtiqueta_15.TabIndex = 99
        Me._lblEtiqueta_15.Text = "*Patente:"
        Me._lblEtiqueta_15.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox5)
        Me.PFormas.Controls.Add(Me.UltraGroupBox3)
        Me.PFormas.Controls.Add(Me.UltraGroupBox4)
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(663, 484)
        Me.PFormas.TabIndex = 0
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox5, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox5, False)
        Me.UltraGroupBox5.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox5.Controls.Add(Me._txtCampo_2)
        Me.UltraGroupBox5.Controls.Add(Me._lblEtiqueta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox5, "Default")
        Me.UltraGroupBox5.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox5.Location = New System.Drawing.Point(10, 164)
        Me.UltraGroupBox5.Name = "UltraGroupBox5"
        Me.UltraGroupBox5.Size = New System.Drawing.Size(641, 35)
        Me.UltraGroupBox5.TabIndex = 99
        Me.UltraGroupBox5.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox5, "")
        '
        'UltraGroupBox3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox3, False)
        Me.UltraGroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox3.Controls.Add(Me.mskCuenta)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox3.Controls.Add(Me.cmbenvioec)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_22)
        Me.UltraGroupBox3.Controls.Add(Me._lblDescripcion_14)
        Me.UltraGroupBox3.Controls.Add(Me.chkFuncionario)
        Me.UltraGroupBox3.Controls.Add(Me._txtCampo_12)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_18)
        Me.UltraGroupBox3.Controls.Add(Me._txtCampo_19)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_15)
        Me.UltraGroupBox3.Controls.Add(Me._txtCampo_7)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_6)
        Me.UltraGroupBox3.Controls.Add(Me._txtCampo_6)
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_5)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox3, "Default")
        Me.UltraGroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox3.Location = New System.Drawing.Point(365, 201)
        Me.UltraGroupBox3.Name = "UltraGroupBox3"
        Me.UltraGroupBox3.Size = New System.Drawing.Size(286, 171)
        Me.UltraGroupBox3.TabIndex = 15
        Me.UltraGroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox3, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(88, 53)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(187, 20)
        Me.mskCuenta.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(6, 57)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "99832")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(80, 14)
        Me._lblEtiqueta_9.TabIndex = 102
        Me._lblEtiqueta_9.Text = "*Cta. Relación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        'UltraGroupBox4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox4, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox4, False)
        Me.UltraGroupBox4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_19)
        Me.UltraGroupBox4.Controls.Add(Me._txtCampo_21)
        Me.UltraGroupBox4.Controls.Add(Me.Label5)
        Me.UltraGroupBox4.Controls.Add(Me._txtCampo_13)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_15)
        Me.UltraGroupBox4.Controls.Add(Me.Lblalianza)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_22)
        Me.UltraGroupBox4.Controls.Add(Me.lbldesalianza)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox4.Controls.Add(Me._txtCampo_3)
        Me.UltraGroupBox4.Controls.Add(Me._optdir_1)
        Me.UltraGroupBox4.Controls.Add(Me._optdir_0)
        Me.UltraGroupBox4.Controls.Add(Me._lblDescripcion_6)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox4, "Default")
        Me.UltraGroupBox4.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox4.Location = New System.Drawing.Point(10, 375)
        Me.UltraGroupBox4.Name = "UltraGroupBox4"
        Me.UltraGroupBox4.Size = New System.Drawing.Size(641, 102)
        Me.UltraGroupBox4.TabIndex = 22
        Me.UltraGroupBox4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox4, "")
        '
        '_lblEtiqueta_19
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_19, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_19, False)
        Me._lblEtiqueta_19.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_19, "Default")
        Me._lblEtiqueta_19.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_19.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_19.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_19.Location = New System.Drawing.Point(7, 56)
        Me._lblEtiqueta_19.Name = "_lblEtiqueta_19"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_19, "501256")
        Me._lblEtiqueta_19.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_19.Size = New System.Drawing.Size(139, 20)
        Me._lblEtiqueta_19.TabIndex = 99
        Me._lblEtiqueta_19.Text = "*Código de dirección:"
        Me._lblEtiqueta_19.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_19, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(7, 56)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "501256")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(139, 20)
        Me._lblEtiqueta_12.TabIndex = 92
        Me._lblEtiqueta_12.Text = "*Código de dirección:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_15)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_20)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_18)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_7)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_13)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_7)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_12)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_11)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_14)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_5)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_20)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_4)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_25)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_8)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 201)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.Size = New System.Drawing.Size(349, 171)
        Me.UltraGroupBox2.TabIndex = 7
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        '_txtCampo_15
        '
        Me._txtCampo_15.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_15, False)
        Me._txtCampo_15.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_15, "Default")
        Me._txtCampo_15.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_15.Location = New System.Drawing.Point(150, 146)
        Me._txtCampo_15.MaxLength = 40
        Me._txtCampo_15.Multiline = True
        Me._txtCampo_15.Name = "_txtCampo_15"
        Me._txtCampo_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_15.Size = New System.Drawing.Size(191, 20)
        Me._txtCampo_15.TabIndex = 14
        Me._txtCampo_15.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_15, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_16)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_13)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_11)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_14)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_10)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_4)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_5)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 6)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(641, 79)
        Me.UltraGroupBox1.TabIndex = 1
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.GroupBox1.Controls.Add(Me.rptReporte)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(11, 89)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "501079")
        Me.GroupBox1.Size = New System.Drawing.Size(640, 74)
        Me.GroupBox1.TabIndex = 5
        Me.GroupBox1.Text = "*Lista de Propietarios:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBAnadir, Me.TSBEliminar, Me.TSBPerfil, Me.TSBBuscar, Me.TSBCanales, Me.TSBContrato, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(687, 25)
        Me.TSBBotones.TabIndex = 92
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
        '
        'TSBAnadir
        '
        Me.TSBAnadir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBAnadir.Image = CType(resources.GetObject("TSBAnadir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAnadir, "2024")
        Me.TSBAnadir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAnadir.Name = "TSBAnadir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAnadir, "2024")
        Me.TSBAnadir.Size = New System.Drawing.Size(67, 22)
        Me.TSBAnadir.Text = "*Añadir"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2023")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*Eliminar"
        '
        'TSBPerfil
        '
        Me.TSBPerfil.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBPerfil.Image = CType(resources.GetObject("TSBPerfil.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBPerfil, "2032")
        Me.TSBPerfil.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBPerfil.Name = "TSBPerfil"
        Me.COBISResourceProvider.SetResourceID(Me.TSBPerfil, "501159")
        Me.TSBPerfil.Size = New System.Drawing.Size(80, 22)
        Me.TSBPerfil.Text = "*Perfil Cta"
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBCanales
        '
        Me.TSBCanales.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBCanales.Image = CType(resources.GetObject("TSBCanales.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCanales, "2048")
        Me.TSBCanales.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCanales.Name = "TSBCanales"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCanales, "2209")
        Me.TSBCanales.Size = New System.Drawing.Size(73, 22)
        Me.TSBCanales.Text = "*&Canales"
        '
        'TSBContrato
        '
        Me.TSBContrato.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBContrato.Image = CType(resources.GetObject("TSBContrato.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBContrato, "2016")
        Me.TSBContrato.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBContrato.Name = "TSBContrato"
        Me.COBISResourceProvider.SetResourceID(Me.TSBContrato, "2016")
        Me.TSBContrato.Size = New System.Drawing.Size(79, 22)
        Me.TSBContrato.Text = "*&Contrato"
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
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran201Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.Controls.Add(Me._cmdBoton_6)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._txtCampo_11)
        Me.Controls.Add(Me._cmdBoton_7)
        Me.Controls.Add(Me._cmdBoton_9)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._optDireccion_2)
        Me.Controls.Add(Me._optDireccion_1)
        Me.Controls.Add(Me.frmDirecciones)
        Me.Controls.Add(Me._optDirecciondv_3)
        Me.Controls.Add(Me.Frame1dv)
        Me.Controls.Add(Me._optDirecciondv_0)
        Me.Controls.Add(Me._optDirecciondv_2)
        Me.Controls.Add(Me._optDirecciondv_1)
        Me.Controls.Add(Me._optDireccion_0)
        Me.Controls.Add(Me.Mskvalor)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(222, 109)
        Me.Name = "FTran201Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(687, 530)
        Me.Tag = "3010"
        Me.Text = "*Apertura de Cuentas de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.frmDirecciones, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmDirecciones.ResumeLayout(False)
        CType(Me.Frame1dv, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox5, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox5.ResumeLayout(False)
        Me.UltraGroupBox5.PerformLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox3.ResumeLayout(False)
        Me.UltraGroupBox3.PerformLayout()
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox4.ResumeLayout(False)
        Me.UltraGroupBox4.PerformLayout()
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
        Me.txtCampo(21) = _txtCampo_21
        Me.txtCampo(15) = _txtCampo_15
        Me.txtCampo(14) = _txtCampo_14
        Me.txtCampo(18) = _txtCampo_18
        Me.txtCampo(19) = _txtCampo_19
        Me.txtCampo(12) = _txtCampo_12
        Me.txtCampo(11) = _txtCampo_11
        Me.txtCampo(9) = _txtCampo_9
        Me.txtCampo(8) = _txtCampo_8
        Me.txtCampo(10) = _txtCampo_10
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(7) = _txtCampo_7
        Me.txtCampo(13) = _txtCampo_13
        Me.txtCampo(3) = _txtCampo_3
    End Sub
    Sub Initializeoptdir()
        Me.optdir(1) = _optdir_1
        Me.optdir(0) = _optdir_0
    End Sub
    Sub InitializeoptDirecciondv()
        Me.optDirecciondv(1) = _optDirecciondv_1
        Me.optDirecciondv(2) = _optDirecciondv_2
        Me.optDirecciondv(0) = _optDirecciondv_0
        Me.optDirecciondv(3) = _optDirecciondv_3
    End Sub
    Sub InitializeoptDireccion()
        Me.optDireccion(1) = _optDireccion_1
        Me.optDireccion(2) = _optDireccion_2
        Me.optDireccion(3) = _optDireccion_3
        Me.optDireccion(0) = _optDireccion_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(20) = _lblEtiqueta_20
        Me.lblEtiqueta(16) = _lblEtiqueta_16
        Me.lblEtiqueta(25) = _lblEtiqueta_25
        Me.lblEtiqueta(18) = _lblEtiqueta_18
        Me.lblEtiqueta(22) = _lblEtiqueta_22
        Me.lblEtiqueta(19) = _lblEtiqueta_19
        ' Me.lblEtiqueta(17) = _lblEtiqueta_17
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        'Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(15) = _lblEtiqueta_15
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(22) = _lblDescripcion_22
        Me.lblDescripcion(20) = _lblDescripcion_20
        Me.lblDescripcion(14) = _lblDescripcion_14
        Me.lblDescripcion(12) = _lblDescripcion_12
        Me.lblDescripcion(11) = _lblDescripcion_11
        Me.lblDescripcion(13) = _lblDescripcion_13
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(5) = _lblDescripcion_5
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(15) = _lblDescripcion_15
        Me.lblDescripcion(6) = _lblDescripcion_6
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(9) = _cmdBoton_9
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(7) = _cmdBoton_7
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(0) = _Line1_0
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(2) = _Line1_2
    'End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBAnadir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBPerfil As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCanales As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBContrato As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox4 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox5 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_15 As System.Windows.Forms.TextBox
    Friend WithEvents UltraGroupBox3 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _lblEtiqueta_19 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
#End Region
End Class


