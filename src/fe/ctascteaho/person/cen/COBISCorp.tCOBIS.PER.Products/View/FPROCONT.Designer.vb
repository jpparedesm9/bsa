Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FProContClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializeoptPlazo()
		InitializeoptEstado()
		InitializeoptCuota()
		InitializeoptContrac()
		InitializemskCosto()
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
    Private WithEvents _optContrac_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optContrac_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _optEstado_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optEstado_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame5 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Public WithEvents grdProdContractual As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _optPlazo_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optPlazo_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optCuota_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optCuota_1 As System.Windows.Forms.RadioButton
    Public WithEvents Frame3 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _mskCosto_0 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _mskCosto_2 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_14 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents Frame4 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _mskCosto_1 As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(5) As System.Windows.Forms.Button
    Public lblDescripcion(3) As System.Windows.Forms.Label
    Public lblEtiqueta(14) As System.Windows.Forms.Label
    Public mskCosto(2) As COBISCorp.Framework.UI.Components.CobisRealInput
    Public optContrac(1) As System.Windows.Forms.RadioButton
    Public optCuota(1) As System.Windows.Forms.RadioButton
    Public optEstado(1) As System.Windows.Forms.RadioButton
    Public optPlazo(1) As System.Windows.Forms.RadioButton
    Public txtCampo(7) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FProContClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optContrac_0 = New System.Windows.Forms.RadioButton()
        Me._optContrac_1 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me.Frame5 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optEstado_0 = New System.Windows.Forms.RadioButton()
        Me._optEstado_1 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.grdProdContractual = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me.Frame4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me.Frame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optPlazo_0 = New System.Windows.Forms.RadioButton()
        Me._optPlazo_1 = New System.Windows.Forms.RadioButton()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.Frame3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optCuota_0 = New System.Windows.Forms.RadioButton()
        Me._optCuota_1 = New System.Windows.Forms.RadioButton()
        Me._mskCosto_0 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_14 = New System.Windows.Forms.Label()
        Me._mskCosto_1 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar2 = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._mskCosto_2 = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me.GroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me.Frame5, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame5.SuspendLayout()
        CType(Me.grdProdContractual, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame4.SuspendLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame2.SuspendLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.GroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox3.SuspendLayout()
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox2.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me._optContrac_0)
        Me.Frame1.Controls.Add(Me._optContrac_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(109, 8)
        Me.Frame1.Name = "Frame1"
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(121, 28)
        Me.Frame1.TabIndex = 9
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        '_optContrac_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optContrac_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optContrac_0, False)
        Me._optContrac_0.BackColor = System.Drawing.Color.Transparent
        Me._optContrac_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optContrac_0, "Default")
        Me._optContrac_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optContrac_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optContrac_0.ForeColor = System.Drawing.Color.Navy
        Me._optContrac_0.Location = New System.Drawing.Point(10, 4)
        Me._optContrac_0.Name = "_optContrac_0"
        Me.COBISResourceProvider.SetResourceID(Me._optContrac_0, "1724")
        Me._optContrac_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optContrac_0.Size = New System.Drawing.Size(44, 20)
        Me._optContrac_0.TabIndex = 13
        Me._optContrac_0.TabStop = True
        Me._optContrac_0.Text = "*Si"
        Me._optContrac_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optContrac_0, "")
        '
        '_optContrac_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optContrac_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optContrac_1, False)
        Me._optContrac_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optContrac_1, "Default")
        Me._optContrac_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optContrac_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optContrac_1.ForeColor = System.Drawing.Color.Navy
        Me._optContrac_1.Location = New System.Drawing.Point(60, 4)
        Me._optContrac_1.Name = "_optContrac_1"
        Me.COBISResourceProvider.SetResourceID(Me._optContrac_1, "1500")
        Me._optContrac_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optContrac_1.Size = New System.Drawing.Size(52, 20)
        Me._optContrac_1.TabIndex = 14
        Me._optContrac_1.Text = "*No"
        Me._optContrac_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optContrac_1, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_3.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_3.Location = New System.Drawing.Point(115, 34)
        Me._txtCampo_3.MaxLength = 3
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_3.TabIndex = 7
        Me._txtCampo_3.Text = "M"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        'Frame5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame5, False)
        Me.Frame5.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame5.Controls.Add(Me._optEstado_0)
        Me.Frame5.Controls.Add(Me._optEstado_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame5, "Default")
        Me.Frame5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame5.ForeColor = System.Drawing.Color.Navy
        Me.Frame5.Location = New System.Drawing.Point(109, 38)
        Me.Frame5.Name = "Frame5"
        Me.Frame5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame5.Size = New System.Drawing.Size(121, 60)
        Me.Frame5.TabIndex = 10
        Me.Frame5.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame5, "")
        '
        '_optEstado_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optEstado_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optEstado_0, False)
        Me._optEstado_0.BackColor = System.Drawing.Color.Transparent
        Me._optEstado_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optEstado_0, "Default")
        Me._optEstado_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optEstado_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optEstado_0.ForeColor = System.Drawing.Color.Navy
        Me._optEstado_0.Location = New System.Drawing.Point(10, 4)
        Me._optEstado_0.Name = "_optEstado_0"
        Me.COBISResourceProvider.SetResourceID(Me._optEstado_0, "1832")
        Me._optEstado_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optEstado_0.Size = New System.Drawing.Size(100, 21)
        Me._optEstado_0.TabIndex = 15
        Me._optEstado_0.TabStop = True
        Me._optEstado_0.Text = "*Vigente"
        Me._optEstado_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optEstado_0, "")
        '
        '_optEstado_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optEstado_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optEstado_1, False)
        Me._optEstado_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optEstado_1, "Default")
        Me._optEstado_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optEstado_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optEstado_1.ForeColor = System.Drawing.Color.Navy
        Me._optEstado_1.Location = New System.Drawing.Point(10, 32)
        Me._optEstado_1.Name = "_optEstado_1"
        Me.COBISResourceProvider.SetResourceID(Me._optEstado_1, "1504")
        Me._optEstado_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optEstado_1.Size = New System.Drawing.Size(100, 20)
        Me._optEstado_1.TabIndex = 16
        Me._optEstado_1.Text = "*No Vigente"
        Me._optEstado_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optEstado_1, "")
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.ScrollBar
        Me._txtCampo_7.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Enabled = False
        Me._txtCampo_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_7.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_7.Location = New System.Drawing.Point(440, 299)
        Me._txtCampo_7.MaxLength = 3
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_7.TabIndex = 40
        Me._txtCampo_7.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.ScrollBar
        Me._txtCampo_6.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Enabled = False
        Me._txtCampo_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_6.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_6.Location = New System.Drawing.Point(440, 275)
        Me._txtCampo_6.MaxLength = 3
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_6.TabIndex = 39
        Me._txtCampo_6.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_2.Location = New System.Drawing.Point(115, 56)
        Me._txtCampo_2.MaxLength = 3
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_2.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_1.Location = New System.Drawing.Point(115, 33)
        Me._txtCampo_1.MaxLength = 4
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_0.Location = New System.Drawing.Point(115, 10)
        Me._txtCampo_0.MaxLength = 5
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'grdProdContractual
        '
        Me.grdProdContractual._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdProdContractual, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdProdContractual, False)
        Me.grdProdContractual.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdProdContractual.Clip = ""
        Me.grdProdContractual.Col = CType(1, Short)
        Me.grdProdContractual.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdProdContractual.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdProdContractual.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdProdContractual, "Default")
        Me.grdProdContractual.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdProdContractual, True)
        Me.grdProdContractual.FixedCols = CType(1, Short)
        Me.grdProdContractual.FixedRows = CType(1, Short)
        Me.grdProdContractual.ForeColor = System.Drawing.Color.Black
        Me.grdProdContractual.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdProdContractual.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdProdContractual.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdProdContractual.HighLight = True
        Me.grdProdContractual.Location = New System.Drawing.Point(11, 20)
        Me.grdProdContractual.Name = "grdProdContractual"
        Me.grdProdContractual.Picture = Nothing
        Me.grdProdContractual.Row = CType(1, Short)
        Me.grdProdContractual.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdProdContractual.Size = New System.Drawing.Size(557, 93)
        Me.grdProdContractual.Sort = CType(2, Short)
        Me.grdProdContractual.TabIndex = 17
        Me.grdProdContractual.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdProdContractual, "")
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
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(506, 40)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 18
        Me._cmdBoton_0.Tag = "4123"
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
        Me._cmdBoton_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.Location = New System.Drawing.Point(506, 96)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 19
        Me._cmdBoton_1.Tag = "4125"
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(506, 147)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 20
        Me._cmdBoton_5.Tag = "4124"
        Me._cmdBoton_5.Text = "&Actualizar"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'Frame4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame4, False)
        Me.Frame4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame4.Controls.Add(Me._txtCampo_4)
        Me.Frame4.Controls.Add(Me._lblEtiqueta_5)
        Me.Frame4.Controls.Add(Me.Frame2)
        Me.Frame4.Controls.Add(Me._lblEtiqueta_6)
        Me.Frame4.Controls.Add(Me.Frame3)
        Me.Frame4.Controls.Add(Me._mskCosto_0)
        Me.Frame4.Controls.Add(Me._lblEtiqueta_13)
        Me.Frame4.Controls.Add(Me._lblEtiqueta_14)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame4, "Default")
        Me.Frame4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame4.ForeColor = System.Drawing.Color.Navy
        Me.Frame4.Location = New System.Drawing.Point(10, 94)
        Me.Frame4.Name = "Frame4"
        Me.Frame4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame4.Size = New System.Drawing.Size(578, 74)
        Me.Frame4.TabIndex = 1
        Me.Frame4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame4, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me._txtCampo_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_4.Location = New System.Drawing.Point(115, 14)
        Me._txtCampo_4.MaxLength = 3
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(54, 20)
        Me._txtCampo_4.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
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
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 14)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "1638")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(47, 13)
        Me._lblEtiqueta_5.TabIndex = 36
        Me._lblEtiqueta_5.Text = "*Plazo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        'Frame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame2, False)
        Me.Frame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame2.Controls.Add(Me._optPlazo_0)
        Me.Frame2.Controls.Add(Me._optPlazo_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame2, "Default")
        Me.Frame2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.Color.Navy
        Me.Frame2.Location = New System.Drawing.Point(429, 10)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(121, 28)
        Me.Frame2.TabIndex = 5
        Me.Frame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame2, "")
        '
        '_optPlazo_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPlazo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPlazo_0, False)
        Me._optPlazo_0.BackColor = System.Drawing.Color.Transparent
        Me._optPlazo_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optPlazo_0, "Default")
        Me._optPlazo_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPlazo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPlazo_0.ForeColor = System.Drawing.Color.Navy
        Me._optPlazo_0.Location = New System.Drawing.Point(10, 4)
        Me._optPlazo_0.Name = "_optPlazo_0"
        Me.COBISResourceProvider.SetResourceID(Me._optPlazo_0, "1724")
        Me._optPlazo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPlazo_0.Size = New System.Drawing.Size(44, 20)
        Me._optPlazo_0.TabIndex = 6
        Me._optPlazo_0.TabStop = True
        Me._optPlazo_0.Text = "*Si"
        Me._optPlazo_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPlazo_0, "")
        '
        '_optPlazo_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPlazo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPlazo_1, False)
        Me._optPlazo_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optPlazo_1, "Default")
        Me._optPlazo_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPlazo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPlazo_1.ForeColor = System.Drawing.Color.Navy
        Me._optPlazo_1.Location = New System.Drawing.Point(60, 6)
        Me._optPlazo_1.Name = "_optPlazo_1"
        Me.COBISResourceProvider.SetResourceID(Me._optPlazo_1, "1500")
        Me._optPlazo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPlazo_1.Size = New System.Drawing.Size(52, 18)
        Me._optPlazo_1.TabIndex = 7
        Me._optPlazo_1.Text = "*No"
        Me._optPlazo_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPlazo_1, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 37)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "1135")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(49, 13)
        Me._lblEtiqueta_6.TabIndex = 35
        Me._lblEtiqueta_6.Text = "*Cuota:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'Frame3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3, False)
        Me.Frame3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3.Controls.Add(Me._optCuota_0)
        Me.Frame3.Controls.Add(Me._optCuota_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3, "Default")
        Me.Frame3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame3.ForeColor = System.Drawing.Color.Navy
        Me.Frame3.Location = New System.Drawing.Point(429, 40)
        Me.Frame3.Name = "Frame3"
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(121, 28)
        Me.Frame3.TabIndex = 6
        Me.Frame3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3, "")
        '
        '_optCuota_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCuota_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCuota_0, False)
        Me._optCuota_0.BackColor = System.Drawing.Color.Transparent
        Me._optCuota_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optCuota_0, "Default")
        Me._optCuota_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCuota_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCuota_0.ForeColor = System.Drawing.Color.Navy
        Me._optCuota_0.Location = New System.Drawing.Point(10, 4)
        Me._optCuota_0.Name = "_optCuota_0"
        Me.COBISResourceProvider.SetResourceID(Me._optCuota_0, "1724")
        Me._optCuota_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCuota_0.Size = New System.Drawing.Size(44, 21)
        Me._optCuota_0.TabIndex = 8
        Me._optCuota_0.TabStop = True
        Me._optCuota_0.Text = "*Si"
        Me._optCuota_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCuota_0, "")
        '
        '_optCuota_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optCuota_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optCuota_1, False)
        Me._optCuota_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optCuota_1, "Default")
        Me._optCuota_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optCuota_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optCuota_1.ForeColor = System.Drawing.Color.Navy
        Me._optCuota_1.Location = New System.Drawing.Point(60, 4)
        Me._optCuota_1.Name = "_optCuota_1"
        Me.COBISResourceProvider.SetResourceID(Me._optCuota_1, "1500")
        Me._optCuota_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optCuota_1.Size = New System.Drawing.Size(52, 18)
        Me._optCuota_1.TabIndex = 9
        Me._optCuota_1.Text = "*No"
        Me._optCuota_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optCuota_1, "")
        '
        '_mskCosto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskCosto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskCosto_0, False)
        Me._mskCosto_0.BackColor = System.Drawing.SystemColors.Window
        Me._mskCosto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskCosto_0, "Default")
        Me._mskCosto_0.DecimalPlaces = 2
        Me._mskCosto_0.Location = New System.Drawing.Point(115, 37)
        Me._mskCosto_0.MaxLength = 15
        Me._mskCosto_0.MaxReal = 0.0!
        Me._mskCosto_0.MinReal = 0.0!
        Me._mskCosto_0.Name = "_mskCosto_0"
        Me._mskCosto_0.Separator = True
        Me._mskCosto_0.Size = New System.Drawing.Size(187, 20)
        Me._mskCosto_0.TabIndex = 4
        Me._mskCosto_0.Text = "0.00"
        Me._mskCosto_0.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskCosto_0.ValueDouble = 0.0R
        Me._mskCosto_0.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskCosto_0, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.AutoSize = True
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(326, 17)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "1496")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(102, 13)
        Me._lblEtiqueta_13.TabIndex = 38
        Me._lblEtiqueta_13.Text = "*Negociar Plazo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        '_lblEtiqueta_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_14, False)
        Me._lblEtiqueta_14.AutoSize = True
        Me._lblEtiqueta_14.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_14, "Default")
        Me._lblEtiqueta_14.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_14.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_14.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_14.Location = New System.Drawing.Point(326, 47)
        Me._lblEtiqueta_14.Name = "_lblEtiqueta_14"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_14, "1495")
        Me._lblEtiqueta_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_14.Size = New System.Drawing.Size(104, 13)
        Me._lblEtiqueta_14.TabIndex = 37
        Me._lblEtiqueta_14.Text = "*Negociar Cuota:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_14, "")
        '
        '_mskCosto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskCosto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskCosto_1, False)
        Me._mskCosto_1.BackColor = System.Drawing.SystemColors.Window
        Me._mskCosto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskCosto_1, "Default")
        Me._mskCosto_1.DecimalPlaces = 2
        Me._mskCosto_1.Enabled = False
        Me._mskCosto_1.Location = New System.Drawing.Point(115, 11)
        Me._mskCosto_1.MaxLength = 13
        Me._mskCosto_1.MaxReal = 3.4E+38!
        Me._mskCosto_1.MinReal = 0.0!
        Me._mskCosto_1.Name = "_mskCosto_1"
        Me._mskCosto_1.Separator = True
        Me._mskCosto_1.Size = New System.Drawing.Size(187, 20)
        Me._mskCosto_1.TabIndex = 7
        Me._mskCosto_1.TabStop = False
        Me._mskCosto_1.Text = "0.00"
        Me._mskCosto_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskCosto_1.ValueDouble = 0.0R
        Me._mskCosto_1.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskCosto_1, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(506, 198)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 21
        Me._cmdBoton_2.Tag = "4126"
        Me._cmdBoton_2.Text = "&Actualizar"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me._cmdBoton_2.Visible = False
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(506, 299)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 22
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(506, 249)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 23
        Me._cmdBoton_3.Text = "&Limpiar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(10, 11)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "1486")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_9.TabIndex = 46
        Me._lblEtiqueta_9.Text = "*Monto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
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
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(6, 15)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "1407")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(88, 13)
        Me._lblEtiqueta_3.TabIndex = 45
        Me._lblEtiqueta_3.Text = "*Imprime Plan:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(172, 34)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(130, 20)
        Me._lblDescripcion_3.TabIndex = 44
        Me._lblDescripcion_3.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.AutoSize = True
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 34)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "1627")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(86, 13)
        Me._lblEtiqueta_8.TabIndex = 43
        Me._lblEtiqueta_8.Text = "*Periodicidad:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(10, 57)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "1676")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(77, 29)
        Me._lblEtiqueta_12.TabIndex = 42
        Me._lblEtiqueta_12.Text = "*Puntos Adicionales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(6, 45)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1340")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(55, 13)
        Me._lblEtiqueta_1.TabIndex = 41
        Me._lblEtiqueta_1.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(172, 56)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(396, 20)
        Me._lblDescripcion_2.TabIndex = 29
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1069")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(81, 20)
        Me._lblEtiqueta_0.TabIndex = 30
        Me._lblEtiqueta_0.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
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
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1668")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(101, 20)
        Me._lblEtiqueta_2.TabIndex = 31
        Me._lblEtiqueta_2.Text = "*Producto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(172, 33)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(396, 20)
        Me._lblDescripcion_1.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(172, 10)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(396, 20)
        Me._lblDescripcion_0.TabIndex = 27
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1738")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(77, 20)
        Me._lblEtiqueta_7.TabIndex = 28
        Me._lblEtiqueta_7.Text = "*Sucursal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.Color.White
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBActualizar2, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(645, 25)
        Me.TSBotones.TabIndex = 47
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
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
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "30005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "1002")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBActualizar2
        '
        Me.TSBActualizar2.Image = CType(resources.GetObject("TSBActualizar2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar2, "30005")
        Me.TSBActualizar2.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar2.Name = "TSBActualizar2"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar2, "1015")
        Me.TSBActualizar2.Size = New System.Drawing.Size(90, 22)
        Me.TSBActualizar2.Text = "*Actualizar2"
        '
        'TSBLimpiar
        '
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
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox3)
        Me.PFormas.Controls.Add(Me.GroupBox2)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.Frame4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(4, 32)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(599, 430)
        Me.PFormas.TabIndex = 48
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_9)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_3)
        Me.UltraGroupBox1.Controls.Add(Me._mskCosto_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_12)
        Me.UltraGroupBox1.Controls.Add(Me._mskCosto_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 171)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(314, 102)
        Me.UltraGroupBox1.TabIndex = 2
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        '_mskCosto_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskCosto_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskCosto_2, False)
        Me._mskCosto_2.BackColor = System.Drawing.SystemColors.Window
        Me._mskCosto_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._mskCosto_2, "Default")
        Me._mskCosto_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!)
        Me._mskCosto_2.Location = New System.Drawing.Point(115, 57)
        Me._mskCosto_2.MaxLength = 5
        Me._mskCosto_2.MaxReal = 3.402823E+38!
        Me._mskCosto_2.MinReal = -3.402823E+38!
        Me._mskCosto_2.Name = "_mskCosto_2"
        Me._mskCosto_2.Size = New System.Drawing.Size(54, 20)
        Me._mskCosto_2.TabIndex = 8
        Me._mskCosto_2.Text = "0.00"
        Me._mskCosto_2.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._mskCosto_2.ValueDouble = 0.0R
        Me._mskCosto_2.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskCosto_2, "")
        '
        'GroupBox3
        '
        Me.GroupBox3.AccessibleRole = System.Windows.Forms.AccessibleRole.None
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox3, False)
        Me.GroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox3.Controls.Add(Me.grdProdContractual)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox3, "Default")
        Me.GroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox3.Location = New System.Drawing.Point(10, 279)
        Me.GroupBox3.Name = "GroupBox3"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox3, "502078")
        Me.GroupBox3.Size = New System.Drawing.Size(578, 122)
        Me.GroupBox3.TabIndex = 4
        Me.GroupBox3.Text = "*Productos Contractuales:"
        Me.GroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox3, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox2.Controls.Add(Me._txtCampo_5)
        Me.GroupBox2.Controls.Add(Me._lblEtiqueta_3)
        Me.GroupBox2.Controls.Add(Me.Frame1)
        Me.GroupBox2.Controls.Add(Me.Frame5)
        Me.GroupBox2.Controls.Add(Me._lblEtiqueta_1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox2.Location = New System.Drawing.Point(330, 171)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(258, 102)
        Me.GroupBox2.TabIndex = 3
        Me.GroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        '_txtCampo_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Location = New System.Drawing.Point(440, 250)
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.Size = New System.Drawing.Size(100, 20)
        Me._txtCampo_5.TabIndex = 48
        Me._txtCampo_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.GroupBox1.Controls.Add(Me._txtCampo_0)
        Me.GroupBox1.Controls.Add(Me._txtCampo_1)
        Me.GroupBox1.Controls.Add(Me._txtCampo_2)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(578, 82)
        Me.GroupBox1.TabIndex = 0
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
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
        'FProContClass
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
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(59, 90)
        Me.Name = "FProContClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(645, 486)
        Me.Text = "*Caracteristicas Especiales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        CType(Me.Frame5, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame5.ResumeLayout(False)
        CType(Me.grdProdContractual, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame4.ResumeLayout(False)
        Me.Frame4.PerformLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame2.ResumeLayout(False)
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me.GroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox3.ResumeLayout(False)
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(7) = _txtCampo_7
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(4) = _txtCampo_4
    End Sub
    Sub InitializeoptPlazo()
        Me.optPlazo(0) = _optPlazo_0
        Me.optPlazo(1) = _optPlazo_1
    End Sub
    Sub InitializeoptEstado()
        Me.optEstado(0) = _optEstado_0
        Me.optEstado(1) = _optEstado_1
    End Sub
    Sub InitializeoptCuota()
        Me.optCuota(0) = _optCuota_0
        Me.optCuota(1) = _optCuota_1
    End Sub
    Sub InitializeoptContrac()
        Me.optContrac(0) = _optContrac_0
        Me.optContrac(1) = _optContrac_1
    End Sub
    Sub InitializemskCosto()
        Me.mskCosto(0) = _mskCosto_0
        Me.mskCosto(1) = _mskCosto_1
        Me.mskCosto(2) = _mskCosto_2
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(14) = _lblEtiqueta_14
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(7) = _lblEtiqueta_7
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub

    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox3 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar2 As System.Windows.Forms.ToolStripButton
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


