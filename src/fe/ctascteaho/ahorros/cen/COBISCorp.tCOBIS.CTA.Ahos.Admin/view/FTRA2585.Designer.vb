Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FTran2585Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializelblEtiqueta()
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
    Private WithEvents _txtCampo_8 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Public WithEvents lblDescripcion As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public Line1(0) As System.Windows.Forms.Label
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public txtCampo(8) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran2585Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_8 = New System.Windows.Forms.TextBox()
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me.lblDescripcion = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        '_txtCampo_8
        '
        Me._txtCampo_8.AcceptsReturn = True
        Me._txtCampo_8.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_8, False)
        Me._txtCampo_8.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_8, "Default")
        Me._txtCampo_8.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_8.Location = New System.Drawing.Point(498, 59)
        Me._txtCampo_8.MaxLength = 3
        Me._txtCampo_8.Name = "_txtCampo_8"
        Me._txtCampo_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_8.Size = New System.Drawing.Size(66, 18)
        Me._txtCampo_8.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_8, "")
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me._txtCampo_7.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Location = New System.Drawing.Point(498, 36)
        Me._txtCampo_7.MaxLength = 3
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(66, 18)
        Me._txtCampo_7.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Location = New System.Drawing.Point(218, 59)
        Me._txtCampo_6.MaxLength = 6
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_6.TabIndex = 6
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
        Me._txtCampo_5.Location = New System.Drawing.Point(178, 59)
        Me._txtCampo_5.MaxLength = 4
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_5.TabIndex = 5
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
        Me._txtCampo_4.Location = New System.Drawing.Point(140, 59)
        Me._txtCampo_4.MaxLength = 4
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_4.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(218, 36)
        Me._txtCampo_3.MaxLength = 6
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_3.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(178, 36)
        Me._txtCampo_2.MaxLength = 4
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_2.TabIndex = 2
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
        Me._txtCampo_1.Location = New System.Drawing.Point(140, 36)
        Me._txtCampo_1.MaxLength = 4
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(37, 18)
        Me._txtCampo_1.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-615, 319)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 15
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Salir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_6.Location = New System.Drawing.Point(-615, 19)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 9
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Text = "*&Buscar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(-615, 69)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 10
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*Siguien&tes"
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
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-615, 219)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 13
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Tag = "2516"
        Me._cmdBoton_2.Text = "*&Eliminar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-615, 119)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 11
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "2548"
        Me._cmdBoton_3.Text = "*&Crear"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-615, 169)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 12
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Tag = "2549"
        Me._cmdBoton_4.Text = "*&Actualizar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me.grdRegistros.Cols = 4
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
        Me.grdRegistros.Size = New System.Drawing.Size(569, 251)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 16
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(140, 13)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(75, 18)
        Me._txtCampo_0.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-615, 269)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(71, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 14
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_lblEtiqueta_3
        '
        Me._lblEtiqueta_3.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(315, 59)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "503244")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(97, 20)
        Me._lblEtiqueta_3.TabIndex = 23
        Me._lblEtiqueta_3.Text = "*Código contable:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        'lblDescripcion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescripcion, False)
        Me.lblDescripcion.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescripcion.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescripcion, "Default")
        Me.lblDescripcion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescripcion.Location = New System.Drawing.Point(218, 13)
        Me.lblDescripcion.Name = "lblDescripcion"
        Me.lblDescripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescripcion.Size = New System.Drawing.Size(346, 18)
        Me.lblDescripcion.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescripcion, "")
        '
        '_lblEtiqueta_1
        '
        Me._lblEtiqueta_1.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(315, 36)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500276")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(175, 20)
        Me._lblEtiqueta_1.TabIndex = 21
        Me._lblEtiqueta_1.Text = "*Número de días de Retención:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 59)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "503243")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(118, 20)
        Me._lblEtiqueta_6.TabIndex = 20
        Me._lblEtiqueta_6.Text = "*Banco Corresponsal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 36)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "503242")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(90, 20)
        Me._lblEtiqueta_2.TabIndex = 19
        Me._lblEtiqueta_2.Text = "*Banco Remesa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 13)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "503241")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(103, 20)
        Me._lblEtiqueta_0.TabIndex = 18
        Me._lblEtiqueta_0.Text = "*Ciudad de Origen:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_6)
        Me.PFormas.Controls.Add(Me._cmdBoton_5)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(595, 384)
        Me.PFormas.TabIndex = 26
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me.lblDescripcion)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_8)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_1)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_7)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_6)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_3)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_5)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_6)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_4)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(575, 90)
        Me.UltraGroupBox1.TabIndex = 0
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 103)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "503245")
        Me.GroupBox1.Size = New System.Drawing.Size(575, 270)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.Text = "*Ruta y Tránsito Existentes:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBBotones, "Default")
        Me.TSBBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBBotones.Name = "TSBBotones"
        Me.TSBBotones.Size = New System.Drawing.Size(615, 25)
        Me.TSBBotones.TabIndex = 27
        Me.TSBBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBBotones, "")
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
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2020")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "500006")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*Siguien&tes"
        '
        'TSBCrear
        '
        Me.TSBCrear.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
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
        Me.TSBEliminar.Text = "*&Eliminar"
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
        'FTran2585Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(74, 122)
        Me.Name = "FTran2585Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(615, 429)
        Me.Text = "Ruta y Tránsito"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
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
        Me.txtCampo(8) = _txtCampo_8
        Me.txtCampo(7) = _txtCampo_7
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        ' Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    ' Sub InitializeLine1()
    '     Me.Line1(0) = _Line1_0
    ' End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


