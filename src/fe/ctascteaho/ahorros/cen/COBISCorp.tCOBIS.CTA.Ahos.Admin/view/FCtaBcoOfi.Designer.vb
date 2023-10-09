Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FCtaBcoOfiClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializelblEtiquetas()
		InitializelblDescripcion()
		InitializecmdBoton()
		InitializeOptcompensa()
		InitializeLine1()
		InitializeFrame4()
		InitializeFrame1()
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
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _Frame1_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _Optcompensa_0 As System.Windows.Forms.RadioButton
    Private WithEvents _Optcompensa_1 As System.Windows.Forms.RadioButton
    Public WithEvents FrmComprensa As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _lblEtiquetas_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiquetas_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Public WithEvents Frame3 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiquetas_0 As System.Windows.Forms.Label
    Private WithEvents _Frame4_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _lblEtiquetas_1 As System.Windows.Forms.Label
	Private WithEvents _Line1_1 As System.Windows.Forms.Label
	Public Frame1(0) As Infragistics.Win.Misc.UltraGroupBox
	Public Frame4(0) As Infragistics.Win.Misc.UltraGroupBox
	Public Line1(2) As System.Windows.Forms.Label
	Public Optcompensa(1) As System.Windows.Forms.RadioButton
	Public cmdBoton(5) As System.Windows.Forms.Button
	Public lblDescripcion(2) As System.Windows.Forms.Label
	Public lblEtiquetas(3) As System.Windows.Forms.Label
	Public txtCampo(2) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FCtaBcoOfiClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._Frame1_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._Frame4_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Frame3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.FrmComprensa = New Infragistics.Win.Misc.UltraGroupBox()
        Me._Optcompensa_0 = New System.Windows.Forms.RadioButton()
        Me._Optcompensa_1 = New System.Windows.Forms.RadioButton()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._lblEtiquetas_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiquetas_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiquetas_0 = New System.Windows.Forms.Label()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._lblEtiquetas_1 = New System.Windows.Forms.Label()
        Me._Line1_1 = New System.Windows.Forms.Label()
        Me.PFORMAS = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBModificar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame1_0.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_0.SuspendLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3.SuspendLayout()
        CType(Me.FrmComprensa, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmComprensa.SuspendLayout()
        CType(Me.PFORMAS, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFORMAS.SuspendLayout()
        Me.TBotones.SuspendLayout()
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
        '_Frame1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame1_0, False)
        Me._Frame1_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame1_0.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame1_0, "Default")
        Me._Frame1_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame1_0.Location = New System.Drawing.Point(6, 166)
        Me._Frame1_0.Name = "_Frame1_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame1_0, "508861")
        Me._Frame1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame1_0.Size = New System.Drawing.Size(546, 228)
        Me._Frame1_0.TabIndex = 9
        Me._Frame1_0.Text = "Cuenta de Consignacion en Banco x Oficina"
        Me._Frame1_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame1_0, "")
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
        Me.grdRegistros.Location = New System.Drawing.Point(8, 16)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(529, 202)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 10
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_Frame4_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_0, False)
        Me._Frame4_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_0.Controls.Add(Me.Frame3)
        Me._Frame4_0.Controls.Add(Me._txtCampo_0)
        Me._Frame4_0.Controls.Add(Me._lblDescripcion_0)
        Me._Frame4_0.Controls.Add(Me._lblEtiquetas_0)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_0, "Default")
        Me._Frame4_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_0.Location = New System.Drawing.Point(10, 10)
        Me._Frame4_0.Name = "_Frame4_0"
        Me._Frame4_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_0.Size = New System.Drawing.Size(545, 144)
        Me._Frame4_0.TabIndex = 8
        Me._Frame4_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_0, "")
        '
        'Frame3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3, False)
        Me.Frame3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3.Controls.Add(Me.FrmComprensa)
        Me.Frame3.Controls.Add(Me._txtCampo_1)
        Me.Frame3.Controls.Add(Me._txtCampo_2)
        Me.Frame3.Controls.Add(Me._lblEtiquetas_3)
        Me.Frame3.Controls.Add(Me._lblDescripcion_1)
        Me.Frame3.Controls.Add(Me._lblEtiquetas_2)
        Me.Frame3.Controls.Add(Me._lblDescripcion_2)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3, "Default")
        Me.Frame3.ForeColor = System.Drawing.Color.Navy
        Me.Frame3.Location = New System.Drawing.Point(10, 43)
        Me.Frame3.Name = "Frame3"
        Me.COBISResourceProvider.SetResourceID(Me.Frame3, "508860")
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(529, 89)
        Me.Frame3.TabIndex = 2
        Me.Frame3.Text = "Compensa?"
        Me.Frame3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3, "")
        '
        'FrmComprensa
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmComprensa, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmComprensa, False)
        Me.FrmComprensa.BackColorInternal = System.Drawing.SystemColors.Control
        Me.FrmComprensa.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.Rounded
        Me.FrmComprensa.Controls.Add(Me._Optcompensa_0)
        Me.FrmComprensa.Controls.Add(Me._Optcompensa_1)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmComprensa, "Default")
        Me.FrmComprensa.Cursor = System.Windows.Forms.Cursors.Default
        Me.FrmComprensa.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrmComprensa.ForeColor = System.Drawing.SystemColors.ControlText
        Me.FrmComprensa.Location = New System.Drawing.Point(109, 8)
        Me.FrmComprensa.Name = "FrmComprensa"
        Me.FrmComprensa.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmComprensa.Size = New System.Drawing.Size(177, 33)
        Me.FrmComprensa.TabIndex = 3
        Me.FrmComprensa.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmComprensa, "")
        '
        '_Optcompensa_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcompensa_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcompensa_0, False)
        Me._Optcompensa_0.BackColor = System.Drawing.Color.Transparent
        Me._Optcompensa_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._Optcompensa_0, "Default")
        Me._Optcompensa_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcompensa_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcompensa_0.Location = New System.Drawing.Point(8, 8)
        Me._Optcompensa_0.Name = "_Optcompensa_0"
        Me.COBISResourceProvider.SetResourceID(Me._Optcompensa_0, "5118")
        Me._Optcompensa_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcompensa_0.Size = New System.Drawing.Size(40, 22)
        Me._Optcompensa_0.TabIndex = 4
        Me._Optcompensa_0.TabStop = True
        Me._Optcompensa_0.Text = "Si"
        Me._Optcompensa_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcompensa_0, "")
        '
        '_Optcompensa_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Optcompensa_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Optcompensa_1, False)
        Me._Optcompensa_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Optcompensa_1, "Default")
        Me._Optcompensa_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Optcompensa_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._Optcompensa_1.Location = New System.Drawing.Point(124, 8)
        Me._Optcompensa_1.Name = "_Optcompensa_1"
        Me.COBISResourceProvider.SetResourceID(Me._Optcompensa_1, "5119")
        Me._Optcompensa_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Optcompensa_1.Size = New System.Drawing.Size(40, 22)
        Me._Optcompensa_1.TabIndex = 5
        Me._Optcompensa_1.TabStop = True
        Me._Optcompensa_1.Text = "No"
        Me._Optcompensa_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Optcompensa_1, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Enabled = False
        Me._txtCampo_1.Location = New System.Drawing.Point(109, 43)
        Me._txtCampo_1.MaxLength = 3
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(115, 20)
        Me._txtCampo_1.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
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
        Me._txtCampo_2.Location = New System.Drawing.Point(109, 66)
        Me._txtCampo_2.MaxLength = 15
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(115, 20)
        Me._txtCampo_2.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_lblEtiquetas_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_3, False)
        Me._lblEtiquetas_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_3, "Default")
        Me._lblEtiquetas_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_3.Location = New System.Drawing.Point(48, 45)
        Me._lblEtiquetas_3.Name = "_lblEtiquetas_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiquetas_3, "501638")
        Me._lblEtiquetas_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_3.Size = New System.Drawing.Size(41, 20)
        Me._lblEtiquetas_3.TabIndex = 21
        Me._lblEtiquetas_3.Text = "Banco:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_3, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(225, 43)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(293, 20)
        Me._lblDescripcion_1.TabIndex = 20
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiquetas_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_2, False)
        Me._lblEtiquetas_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_2, "Default")
        Me._lblEtiquetas_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_2.Location = New System.Drawing.Point(48, 66)
        Me._lblEtiquetas_2.Name = "_lblEtiquetas_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiquetas_2, "502158")
        Me._lblEtiquetas_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_2.Size = New System.Drawing.Size(45, 20)
        Me._lblEtiquetas_2.TabIndex = 19
        Me._lblEtiquetas_2.Text = "Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_2, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(225, 66)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(293, 20)
        Me._lblDescripcion_2.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(118, 10)
        Me._txtCampo_0.MaxLength = 5
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(59, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(178, 10)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(349, 20)
        Me._lblDescripcion_0.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiquetas_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_0, False)
        Me._lblEtiquetas_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_0, "Default")
        Me._lblEtiquetas_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiquetas_0.Name = "_lblEtiquetas_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiquetas_0, "502694")
        Me._lblEtiquetas_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_0.Size = New System.Drawing.Size(104, 20)
        Me._lblEtiquetas_0.TabIndex = 14
        Me._lblEtiquetas_0.Text = "Codigo de oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_0, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-559, 125)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 6
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "697"
        Me._cmdBoton_1.Text = "&Ingresar"
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-559, 287)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 9
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "&Limpiar"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_0.Location = New System.Drawing.Point(-560, 23)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 5
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "696"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_2.Enabled = False
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(-559, 179)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 7
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Tag = "697"
        Me._cmdBoton_2.Text = "&Eliminar"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_5.Image = CType(resources.GetObject("_cmdBoton_5.Image"), System.Drawing.Image)
        Me._cmdBoton_5.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_5.Location = New System.Drawing.Point(-560, 341)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 10
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "&Salir"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_3.Location = New System.Drawing.Point(-559, 234)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(57, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "697"
        Me._cmdBoton_3.Text = "&Modificar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_lblEtiquetas_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiquetas_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiquetas_1, False)
        Me._lblEtiquetas_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiquetas_1, "Default")
        Me._lblEtiquetas_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiquetas_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiquetas_1.Location = New System.Drawing.Point(176, 219)
        Me._lblEtiquetas_1.Name = "_lblEtiquetas_1"
        Me._lblEtiquetas_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiquetas_1.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiquetas_1.TabIndex = 16
        Me._lblEtiquetas_1.Text = "Codigo de la oficina:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiquetas_1, "")
        '
        '_Line1_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Line1_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Line1_1, False)
        Me._Line1_1.BackColor = System.Drawing.Color.Navy
        Me.COBISStyleProvider.SetControlStyle(Me._Line1_1, "Default")
        Me._Line1_1.ForeColor = System.Drawing.Color.Navy
        Me._Line1_1.Location = New System.Drawing.Point(278, 19)
        Me._Line1_1.Name = "_Line1_1"
        Me._Line1_1.Size = New System.Drawing.Size(1, 20)
        Me._Line1_1.TabIndex = 17
        Me._Line1_1.Text = "_Line1_1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Line1_1, "")
        '
        'PFORMAS
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFORMAS, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFORMAS, False)
        Me.PFORMAS.BackColorInternal = System.Drawing.Color.White
        Me.PFORMAS.Controls.Add(Me._Frame4_0)
        Me.PFORMAS.Controls.Add(Me._Frame1_0)
        Me.PFORMAS.Controls.Add(Me._Line1_1)
        Me.PFORMAS.Controls.Add(Me._lblEtiquetas_1)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_1)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_4)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_3)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_0)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_5)
        Me.PFORMAS.Controls.Add(Me._cmdBoton_2)
        Me.COBISStyleProvider.SetControlStyle(Me.PFORMAS, "Default")
        Me.PFORMAS.Location = New System.Drawing.Point(10, 36)
        Me.PFORMAS.Name = "PFORMAS"
        Me.PFORMAS.Size = New System.Drawing.Size(564, 400)
        Me.PFORMAS.TabIndex = 18
        Me.PFORMAS.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFORMAS, "")
        '
        'TBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TBotones, "Default")
        Me.TBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBIngresar, Me.TSBEliminar, Me.TSBModificar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TBotones.Location = New System.Drawing.Point(0, 0)
        Me.TBotones.Name = "TBotones"
        Me.TBotones.Size = New System.Drawing.Size(583, 25)
        Me.TBotones.TabIndex = 19
        Me.TBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBIngresar
        '
        Me.TSBIngresar.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar.Image = CType(resources.GetObject("TSBIngresar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar.Name = "TSBIngresar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar, "500493")
        Me.TSBIngresar.Size = New System.Drawing.Size(74, 22)
        Me.TSBIngresar.Text = "*&Ingresar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBModificar
        '
        Me.TSBModificar.ForeColor = System.Drawing.Color.Black
        Me.TSBModificar.Image = CType(resources.GetObject("TSBModificar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBModificar, "2005")
        Me.TSBModificar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBModificar.Name = "TSBModificar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBModificar, "500173")
        Me.TSBModificar.Size = New System.Drawing.Size(83, 22)
        Me.TSBModificar.Text = "*&Modificar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FCtaBcoOfiClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TBotones)
        Me.Controls.Add(Me.PFORMAS)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(3, 120)
        Me.Name = "FCtaBcoOfiClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(583, 443)
        Me.Tag = "672"
        Me.Text = "Parametrización Cuenta de Consignación por Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame1_0.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_0.ResumeLayout(False)
        Me._Frame4_0.PerformLayout()
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3.ResumeLayout(False)
        Me.Frame3.PerformLayout()
        CType(Me.FrmComprensa, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmComprensa.ResumeLayout(False)
        CType(Me.PFORMAS, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFORMAS.ResumeLayout(False)
        Me.TBotones.ResumeLayout(False)
        Me.TBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub InitializelblEtiquetas()
        Me.lblEtiquetas(3) = _lblEtiquetas_3
        Me.lblEtiquetas(2) = _lblEtiquetas_2
        Me.lblEtiquetas(0) = _lblEtiquetas_0
        Me.lblEtiquetas(1) = _lblEtiquetas_1
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Sub InitializeOptcompensa()
        Me.Optcompensa(0) = _Optcompensa_0
        Me.Optcompensa(1) = _Optcompensa_1
    End Sub
    Sub InitializeLine1()
        'Me.Line1(2) = _Line1_2
        Me.Line1(1) = _Line1_1
    End Sub
    Sub InitializeFrame4()
        Me.Frame4(0) = _Frame4_0
    End Sub
    Sub InitializeFrame1()
        Me.Frame1(0) = _Frame1_0
    End Sub

    Friend WithEvents PFORMAS As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBIngresar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBModificar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region 
End Class


