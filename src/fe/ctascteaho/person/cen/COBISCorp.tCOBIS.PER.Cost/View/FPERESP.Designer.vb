Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FPersoEspecialClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializepicVisto()
		InitializelblEtiqueta()
		InitializelblDescripcion()
		InitializegrdServicios()
		InitializecmdBoton()
		InitializeOptAplic()
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
    Friend WithEvents CobisResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents cmbPerso As System.Windows.Forms.ComboBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Public WithEvents cmbCosto As System.Windows.Forms.ComboBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _grdServicios_1 As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _grdServicios_0 As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Public WithEvents mskCosto As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _OptAplic_1 As System.Windows.Forms.RadioButton
    Private WithEvents _OptAplic_0 As System.Windows.Forms.RadioButton
    Public WithEvents FrmAplic As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    ' Private WithEvents _Line1_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    ' Public Line1(1) As System.Windows.Forms.Label
	Public OptAplic(1) As System.Windows.Forms.RadioButton
	Public cmdBoton(3) As System.Windows.Forms.Button
	Public grdServicios(1) As COBISCorp.Framework.UI.Components.COBISGrid
	Public lblDescripcion(4) As System.Windows.Forms.Label
	Public lblEtiqueta(13) As System.Windows.Forms.Label
	Public picVisto(1) As System.Windows.Forms.PictureBox
	Public txtCampo(4) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FPersoEspecialClass))
        Me.cmbPerso = New System.Windows.Forms.ComboBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me.cmbCosto = New System.Windows.Forms.ComboBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._grdServicios_1 = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._grdServicios_0 = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me.mskCosto = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.FrmAplic = New Infragistics.Win.Misc.UltraGroupBox()
        Me._OptAplic_1 = New System.Windows.Forms.RadioButton()
        Me._OptAplic_0 = New System.Windows.Forms.RadioButton()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.ToolStrip1 = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.CobisResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._grdServicios_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._grdServicios_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FrmAplic, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmAplic.SuspendLayout()
        Me.ToolStrip1.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.GroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox3.SuspendLayout()
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'cmbPerso
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbPerso, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbPerso, False)
        Me.cmbPerso.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbPerso, "Default")
        Me.cmbPerso.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbPerso.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbPerso.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmbPerso.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbPerso.Location = New System.Drawing.Point(428, 54)
        Me.cmbPerso.Name = "cmbPerso"
        Me.cmbPerso.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbPerso.Size = New System.Drawing.Size(156, 21)
        Me.cmbPerso.Sorted = True
        Me.cmbPerso.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbPerso, "")
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
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._txtCampo_4.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_4.Location = New System.Drawing.Point(364, 121)
        Me._txtCampo_4.MaxLength = 1
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_4.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        'cmbCosto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbCosto, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbCosto, False)
        Me.cmbCosto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbCosto, "Default")
        Me.cmbCosto.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbCosto.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbCosto.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.cmbCosto.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbCosto.Location = New System.Drawing.Point(139, 76)
        Me.cmbCosto.Name = "cmbCosto"
        Me.cmbCosto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbCosto.Size = New System.Drawing.Size(111, 21)
        Me.cmbCosto.Sorted = True
        Me.cmbCosto.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbCosto, "")
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
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._txtCampo_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_0.Location = New System.Drawing.Point(139, 10)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(522, 2)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_0.TabIndex = 24
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Location = New System.Drawing.Point(537, 2)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 23
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(515, 284)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 49)
        Me._cmdBoton_0.TabIndex = 13
        Me._cmdBoton_0.Tag = "4090"
        Me._cmdBoton_0.Text = "&Transmitir"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmdBoton_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.Location = New System.Drawing.Point(515, 214)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me._cmdBoton_3.TabIndex = 12
        Me._cmdBoton_3.Tag = "4089"
        Me._cmdBoton_3.Text = "&Buscar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._txtCampo_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_2.Location = New System.Drawing.Point(139, 99)
        Me._txtCampo_2.MaxLength = 8
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(111, 20)
        Me._txtCampo_2.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmdBoton_2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.Location = New System.Drawing.Point(516, 385)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me._cmdBoton_2.TabIndex = 15
        Me._cmdBoton_2.Text = "&Salir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
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
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._cmdBoton_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.Location = New System.Drawing.Point(516, 334)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me._cmdBoton_1.TabIndex = 14
        Me._cmdBoton_1.Text = "&Limpiar"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_grdServicios_1
        '
        Me._grdServicios_1._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me._grdServicios_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._grdServicios_1, False)
        Me._grdServicios_1.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me._grdServicios_1.Clip = ""
        Me._grdServicios_1.Col = CType(1, Short)
        Me._grdServicios_1.ColorFixedCols = System.Drawing.SystemColors.Control
        Me._grdServicios_1.ColorFixedRows = System.Drawing.SystemColors.Control
        Me._grdServicios_1.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me._grdServicios_1, "Default")
        Me._grdServicios_1.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me._grdServicios_1, True)
        Me._grdServicios_1.FixedCols = CType(1, Short)
        Me._grdServicios_1.FixedRows = CType(1, Short)
        Me._grdServicios_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._grdServicios_1.ForeColor = System.Drawing.Color.Black
        Me._grdServicios_1.ForeColorFixedCols = System.Drawing.Color.Empty
        Me._grdServicios_1.ForeColorFixedRows = System.Drawing.Color.Empty
        Me._grdServicios_1.GridColor = System.Drawing.SystemColors.ControlDark
        Me._grdServicios_1.HighLight = True
        Me._grdServicios_1.Location = New System.Drawing.Point(6, 19)
        Me._grdServicios_1.Name = "_grdServicios_1"
        Me._grdServicios_1.Picture = Nothing
        Me._grdServicios_1.Row = CType(1, Short)
        Me._grdServicios_1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me._grdServicios_1.Size = New System.Drawing.Size(567, 93)
        Me._grdServicios_1.Sort = CType(2, Short)
        Me._grdServicios_1.TabIndex = 28
        Me._grdServicios_1.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me._grdServicios_1, "")
        '
        '_grdServicios_0
        '
        Me._grdServicios_0._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me._grdServicios_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._grdServicios_0, False)
        Me._grdServicios_0.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me._grdServicios_0.Clip = ""
        Me._grdServicios_0.Col = CType(1, Short)
        Me._grdServicios_0.ColorFixedCols = System.Drawing.SystemColors.Control
        Me._grdServicios_0.ColorFixedRows = System.Drawing.SystemColors.Control
        Me._grdServicios_0.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me._grdServicios_0, "Default")
        Me._grdServicios_0.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me._grdServicios_0, True)
        Me._grdServicios_0.FixedCols = CType(1, Short)
        Me._grdServicios_0.FixedRows = CType(1, Short)
        Me._grdServicios_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._grdServicios_0.ForeColor = System.Drawing.Color.Black
        Me._grdServicios_0.ForeColorFixedCols = System.Drawing.Color.Empty
        Me._grdServicios_0.ForeColorFixedRows = System.Drawing.Color.Empty
        Me._grdServicios_0.GridColor = System.Drawing.SystemColors.ControlDark
        Me._grdServicios_0.HighLight = True
        Me._grdServicios_0.Location = New System.Drawing.Point(6, 19)
        Me._grdServicios_0.Name = "_grdServicios_0"
        Me._grdServicios_0.Picture = Nothing
        Me._grdServicios_0.Row = CType(1, Short)
        Me._grdServicios_0.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me._grdServicios_0.Size = New System.Drawing.Size(567, 94)
        Me._grdServicios_0.Sort = CType(2, Short)
        Me._grdServicios_0.TabIndex = 26
        Me._grdServicios_0.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me._grdServicios_0, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.mskCuenta.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(139, 76)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(111, 20)
        Me.mskCuenta.TabIndex = 50
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        'mskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFecha, False)
        Me.mskFecha.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskFecha, "Default")
        Me.mskFecha.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.mskFecha.Length = CType(64, Short)
        Me.mskFecha.Location = New System.Drawing.Point(139, 54)
        Me.mskFecha.MaxReal = 3.402823E+38!
        Me.mskFecha.MinReal = -3.402823E+38!
        Me.mskFecha.Name = "mskFecha"
        Me.mskFecha.Size = New System.Drawing.Size(111, 20)
        Me.mskFecha.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFecha, "")
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
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._txtCampo_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._txtCampo_1.Location = New System.Drawing.Point(139, 76)
        Me._txtCampo_1.MaxLength = 7
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(111, 20)
        Me._txtCampo_1.TabIndex = 52
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        'mskCosto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCosto, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCosto, False)
        Me.mskCosto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskCosto, "Default")
        Me.mskCosto.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.mskCosto.Length = CType(64, Short)
        Me.mskCosto.Location = New System.Drawing.Point(139, 121)
        Me.mskCosto.Mask = "#,##0.00"
        Me.mskCosto.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.Numeric
        Me.mskCosto.MaxReal = 3.402823E+38!
        Me.mskCosto.MinReal = -3.402823E+38!
        Me.mskCosto.Name = "mskCosto"
        Me.mskCosto.Size = New System.Drawing.Size(112, 20)
        Me.mskCosto.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCosto, "")
        '
        'FrmAplic
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmAplic, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmAplic, False)
        Me.FrmAplic.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmAplic.Controls.Add(Me._OptAplic_1)
        Me.FrmAplic.Controls.Add(Me._OptAplic_0)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmAplic, "Default")
        Me.FrmAplic.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrmAplic.ForeColor = System.Drawing.Color.Navy
        Me.FrmAplic.Location = New System.Drawing.Point(422, 76)
        Me.FrmAplic.Name = "FrmAplic"
        Me.FrmAplic.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmAplic.Size = New System.Drawing.Size(162, 20)
        Me.FrmAplic.TabIndex = 14
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmAplic, "")
        '
        '_OptAplic_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptAplic_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptAplic_1, False)
        Me._OptAplic_1.AutoSize = True
        Me._OptAplic_1.BackColor = System.Drawing.Color.Transparent
        Me._OptAplic_1.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.COBISStyleProvider.SetControlStyle(Me._OptAplic_1, "Default")
        Me._OptAplic_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptAplic_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptAplic_1.ForeColor = System.Drawing.Color.Navy
        Me._OptAplic_1.Location = New System.Drawing.Point(93, 2)
        Me._OptAplic_1.Name = "_OptAplic_1"
        Me.CobisResourceProvider.SetResourceID(Me._OptAplic_1, "1534")
        Me._OptAplic_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptAplic_1.Size = New System.Drawing.Size(70, 17)
        Me._OptAplic_1.TabIndex = 16
        Me._OptAplic_1.TabStop = True
        Me._OptAplic_1.Text = "*Oficina"
        Me._OptAplic_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptAplic_1, "")
        '
        '_OptAplic_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptAplic_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptAplic_0, False)
        Me._OptAplic_0.AutoSize = True
        Me._OptAplic_0.BackColor = System.Drawing.Color.Transparent
        Me._OptAplic_0.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me._OptAplic_0.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._OptAplic_0, "Default")
        Me._OptAplic_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptAplic_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptAplic_0.ForeColor = System.Drawing.Color.Navy
        Me._OptAplic_0.Location = New System.Drawing.Point(6, 2)
        Me._OptAplic_0.Name = "_OptAplic_0"
        Me.CobisResourceProvider.SetResourceID(Me._OptAplic_0, "1492")
        Me._OptAplic_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptAplic_0.Size = New System.Drawing.Size(80, 17)
        Me._OptAplic_0.TabIndex = 15
        Me._OptAplic_0.TabStop = True
        Me._OptAplic_0.Text = "*Nacional"
        Me._OptAplic_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptAplic_0, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.AutoSize = True
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(276, 76)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_9, "1743")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(104, 13)
        Me._lblEtiqueta_9.TabIndex = 13
        Me._lblEtiqueta_9.Text = "*Tipo Aplicación:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
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
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(276, 121)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_8, "1750")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(90, 13)
        Me._lblEtiqueta_8.TabIndex = 22
        Me._lblEtiqueta_8.Text = "*Tipo de Dato:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblDescripcion_4.Location = New System.Drawing.Point(428, 121)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(156, 20)
        Me._lblDescripcion_4.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblDescripcion_3.Location = New System.Drawing.Point(139, 32)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(62, 20)
        Me._lblDescripcion_3.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(11, 76)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1769")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(95, 13)
        Me._lblEtiqueta_0.TabIndex = 10
        Me._lblEtiqueta_0.Text = "*Tipo de Costo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
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
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(11, 32)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1693")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(50, 13)
        Me._lblEtiqueta_7.TabIndex = 3
        Me._lblEtiqueta_7.Text = "*Rubro:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblDescripcion_2.Location = New System.Drawing.Point(202, 32)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(382, 20)
        Me._lblDescripcion_2.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(11, 10)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_6, "1712")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(125, 13)
        Me._lblEtiqueta_6.TabIndex = 0
        Me._lblEtiqueta_6.Text = "*Servicio Disponible:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblDescripcion_1.Location = New System.Drawing.Point(202, 10)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(382, 20)
        Me._lblDescripcion_1.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.AutoSize = True
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(11, 54)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_13, "1370")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(104, 13)
        Me._lblEtiqueta_13.TabIndex = 6
        Me._lblEtiqueta_13.Text = "*Fecha Vigencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(276, 54)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1634")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(127, 13)
        Me._lblEtiqueta_1.TabIndex = 8
        Me._lblEtiqueta_1.Text = "*Personalización por:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(11, 121)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_3, "1802")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(69, 13)
        Me._lblEtiqueta_3.TabIndex = 20
        Me._lblEtiqueta_3.Text = "*Valor Fijo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me._lblDescripcion_0.Location = New System.Drawing.Point(251, 99)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(333, 20)
        Me._lblDescripcion_0.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(11, 99)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.CobisResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1516")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(84, 13)
        Me._lblEtiqueta_2.TabIndex = 17
        Me._lblEtiqueta_2.Text = "*Nro. Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'ToolStrip1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ToolStrip1, False)
        Me.COBISViewResizer.SetAutoResize(Me.ToolStrip1, False)
        Me.COBISStyleProvider.SetControlStyle(Me.ToolStrip1, "Default")
        Me.ToolStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.ToolStrip1.Location = New System.Drawing.Point(0, 0)
        Me.ToolStrip1.Name = "ToolStrip1"
        Me.ToolStrip1.Size = New System.Drawing.Size(610, 25)
        Me.ToolStrip1.TabIndex = 36
        Me.ToolStrip1.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ToolStrip1, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.CobisResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.CobisResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.CobisResourceProvider.SetImageID(Me.TSBTransmitir, "30007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.CobisResourceProvider.SetResourceID(Me.TSBTransmitir, "1009")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.CobisResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.CobisResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.CobisResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.CobisResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(49, 22)
        Me.TSBSalir.Text = "Salir"
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.GroupBox3)
        Me.GroupBox1.Controls.Add(Me.GroupBox2)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.GroupBox1.Controls.Add(Me.cmbPerso)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.GroupBox1.Controls.Add(Me._txtCampo_4)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_3)
        Me.GroupBox1.Controls.Add(Me.cmbCosto)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_1)
        Me.GroupBox1.Controls.Add(Me._txtCampo_0)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_13)
        Me.GroupBox1.Controls.Add(Me.FrmAplic)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_6)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_2)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.GroupBox1.Controls.Add(Me._txtCampo_2)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.GroupBox1.Controls.Add(Me._lblDescripcion_4)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_8)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_9)
        Me.GroupBox1.Controls.Add(Me.mskCosto)
        Me.GroupBox1.Controls.Add(Me.mskCuenta)
        Me.GroupBox1.Controls.Add(Me._txtCampo_1)
        Me.GroupBox1.Controls.Add(Me.mskFecha)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 35)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(599, 420)
        Me.GroupBox1.TabIndex = 37
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'GroupBox3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox3, False)
        Me.GroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox3.Controls.Add(Me._grdServicios_1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox3, "Default")
        Me.GroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox3.Location = New System.Drawing.Point(11, 289)
        Me.GroupBox3.Name = "GroupBox3"
        Me.CobisResourceProvider.SetResourceID(Me.GroupBox3, "1827")
        Me.GroupBox3.Size = New System.Drawing.Size(582, 120)
        Me.GroupBox3.TabIndex = 27
        Me.GroupBox3.Text = "*Valores de Costos Personalizados:"
        Me.GroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox3, "")
        '
        'GroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox2, False)
        Me.GroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox2.Controls.Add(Me._grdServicios_0)
        Me.GroupBox2.Controls.Add(Me._picVisto_0)
        Me.GroupBox2.Controls.Add(Me._picVisto_1)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox2, "Default")
        Me.GroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox2.Location = New System.Drawing.Point(11, 158)
        Me.GroupBox2.Name = "GroupBox2"
        Me.CobisResourceProvider.SetResourceID(Me.GroupBox2, "1825")
        Me.GroupBox2.Size = New System.Drawing.Size(582, 121)
        Me.GroupBox2.TabIndex = 25
        Me.GroupBox2.Text = "*Valores de Costos Generales Vigentes:"
        Me.GroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox2, "")
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        'FPersoEspecialClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.ToolStrip1)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(4, 122)
        Me.Name = "FPersoEspecialClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(610, 458)
        Me.Text = "Personalización de Costos Especiales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._grdServicios_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._grdServicios_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FrmAplic, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmAplic.ResumeLayout(False)
        Me.FrmAplic.PerformLayout()
        Me.ToolStrip1.ResumeLayout(False)
        Me.ToolStrip1.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        CType(Me.GroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox3.ResumeLayout(False)
        CType(Me.GroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox2.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(1) = _txtCampo_1
    End Sub
    Sub InitializepicVisto()
        Me.picVisto(0) = _picVisto_0
        Me.picVisto(1) = _picVisto_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializegrdServicios()
        Me.grdServicios(1) = _grdServicios_1
        Me.grdServicios(0) = _grdServicios_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    Sub InitializeOptAplic()
        Me.OptAplic(1) = _OptAplic_1
        Me.OptAplic(0) = _OptAplic_0
    End Sub
    Friend WithEvents ToolStrip1 As System.Windows.Forms.ToolStrip
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox3 As Infragistics.Win.Misc.UltraGroupBox

#End Region
End Class


