Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FPerfilClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
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
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents frmDatos As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents GrdPerfiles As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Public cmdBoton(5) As System.Windows.Forms.Button
	Public lblDescripcion(3) As System.Windows.Forms.Label
	Public lblEtiqueta(3) As System.Windows.Forms.Label
	Public txtCampo(3) As System.Windows.Forms.TextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FPerfilClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.frmDatos = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.GrdPerfiles = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.frmDatos, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmDatos.SuspendLayout()
        CType(Me.GrdPerfiles, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'frmDatos
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmDatos, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmDatos, False)
        Me.frmDatos.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmDatos.Controls.Add(Me._txtCampo_2)
        Me.frmDatos.Controls.Add(Me._txtCampo_0)
        Me.frmDatos.Controls.Add(Me._txtCampo_1)
        Me.frmDatos.Controls.Add(Me._txtCampo_3)
        Me.frmDatos.Controls.Add(Me._lblDescripcion_2)
        Me.frmDatos.Controls.Add(Me._lblEtiqueta_2)
        Me.frmDatos.Controls.Add(Me._lblEtiqueta_1)
        Me.frmDatos.Controls.Add(Me._lblDescripcion_1)
        Me.frmDatos.Controls.Add(Me._lblEtiqueta_3)
        Me.frmDatos.Controls.Add(Me._lblDescripcion_3)
        Me.frmDatos.Controls.Add(Me._lblEtiqueta_0)
        Me.COBISStyleProvider.SetControlStyle(Me.frmDatos, "Default")
        Me.frmDatos.ForeColor = System.Drawing.Color.Navy
        Me.frmDatos.Location = New System.Drawing.Point(10, 10)
        Me.frmDatos.Name = "frmDatos"
        Me.frmDatos.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmDatos.Size = New System.Drawing.Size(532, 114)
        Me.frmDatos.TabIndex = 4
        Me.frmDatos.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmDatos, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(85, 79)
        Me._txtCampo_2.MaxLength = 10
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me.COBISResourceProvider.SetResourceID(Me._txtCampo_2, "508858")
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_2.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(85, 56)
        Me._txtCampo_0.MaxLength = 10
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me.COBISResourceProvider.SetResourceID(Me._txtCampo_0, "508857")
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(85, 10)
        Me._txtCampo_1.MaxLength = 3
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(85, 33)
        Me._txtCampo_3.MaxLength = 7
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_3.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(150, 79)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(368, 20)
        Me._lblDescripcion_2.TabIndex = 18
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "508858")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(74, 20)
        Me._lblEtiqueta_2.TabIndex = 17
        Me._lblEtiqueta_2.Text = "*Tipo Trn:"
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "508857")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(74, 20)
        Me._lblEtiqueta_1.TabIndex = 16
        Me._lblEtiqueta_1.Text = "*Perfil:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(150, 10)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(368, 20)
        Me._lblDescripcion_1.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5048")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(74, 20)
        Me._lblEtiqueta_3.TabIndex = 14
        Me._lblEtiqueta_3.Text = "*Producto:"
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
        Me._lblDescripcion_3.Location = New System.Drawing.Point(150, 33)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(368, 20)
        Me._lblDescripcion_3.TabIndex = 13
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500364")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(74, 20)
        Me._lblEtiqueta_0.TabIndex = 12
        Me._lblEtiqueta_0.Text = "*Transacción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-544, 257)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "4010"
        Me._cmdBoton_3.Text = "*&Eliminar"
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
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-544, 156)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 5
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Tag = "4008"
        Me._cmdBoton_0.Text = "*&Crear"
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
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-544, 207)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 7
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Tag = "4009"
        Me._cmdBoton_4.Text = "*&Actualizar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-544, 308)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 9
        Me._cmdBoton_1.TabStop = False
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-544, 360)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 10
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'GrdPerfiles
        '
        Me.GrdPerfiles._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.GrdPerfiles, False)
        Me.COBISViewResizer.SetAutoResize(Me.GrdPerfiles, False)
        Me.GrdPerfiles.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.GrdPerfiles.Clip = ""
        Me.GrdPerfiles.Col = CType(1, Short)
        Me.GrdPerfiles.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.GrdPerfiles.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.GrdPerfiles.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.GrdPerfiles, "Default")
        Me.GrdPerfiles.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.GrdPerfiles, True)
        Me.GrdPerfiles.FixedCols = CType(1, Short)
        Me.GrdPerfiles.FixedRows = CType(1, Short)
        Me.GrdPerfiles.ForeColor = System.Drawing.Color.Black
        Me.GrdPerfiles.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.GrdPerfiles.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.GrdPerfiles.GridColor = System.Drawing.SystemColors.ControlDark
        Me.GrdPerfiles.HighLight = True
        Me.GrdPerfiles.Location = New System.Drawing.Point(10, 130)
        Me.GrdPerfiles.Name = "GrdPerfiles"
        Me.GrdPerfiles.Picture = Nothing
        Me.GrdPerfiles.Row = CType(1, Short)
        Me.GrdPerfiles.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.GrdPerfiles.Size = New System.Drawing.Size(532, 289)
        Me.GrdPerfiles.Sort = CType(2, Short)
        Me.GrdPerfiles.TabIndex = 5
        Me.GrdPerfiles.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GrdPerfiles, "")
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(-544, 8)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(65, 51)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 0
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Tag = "4011"
        Me._cmdBoton_5.Text = "*&Buscar"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GrdPerfiles)
        Me.PFormas.Controls.Add(Me.frmDatos)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(552, 430)
        Me.PFormas.TabIndex = 14
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(572, 25)
        Me.TSBotones.TabIndex = 15
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
        'TSBCrear
        '
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2002")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2027")
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
        'FPerfilClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_5)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(3, 29)
        Me.Name = "FPerfilClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(572, 477)
        Me.Text = "Perfiles Contables"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.frmDatos, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmDatos.ResumeLayout(False)
        Me.frmDatos.PerformLayout()
        CType(Me.GrdPerfiles, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(3) = _txtCampo_3
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(3) = _lblDescripcion_3
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(5) = _cmdBoton_5
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
#End Region 
End Class


