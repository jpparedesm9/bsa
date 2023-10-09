Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Ftran302Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        Initializetxtcampo()
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
    Private WithEvents _txtcampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtcampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtcampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtcampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdOperaciones As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lbletiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lbletiqueta_0 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public cmdBoton(5) As System.Windows.Forms.Button
    Public lbletiqueta(7) As System.Windows.Forms.Label
    Public txtcampo(3) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Ftran302Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtcampo_2 = New System.Windows.Forms.TextBox()
        Me._txtcampo_1 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._txtcampo_0 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdOperaciones = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._lbletiqueta_7 = New System.Windows.Forms.Label()
        Me._lbletiqueta_6 = New System.Windows.Forms.Label()
        Me._lbletiqueta_5 = New System.Windows.Forms.Label()
        Me._lbletiqueta_4 = New System.Windows.Forms.Label()
        Me._lbletiqueta_2 = New System.Windows.Forms.Label()
        Me._lbletiqueta_3 = New System.Windows.Forms.Label()
        Me._lbletiqueta_0 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtcampo_3 = New System.Windows.Forms.TextBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdOperaciones, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        '_txtcampo_2
        '
        Me._txtcampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_2, False)
        Me._txtcampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_2, "Default")
        Me._txtcampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_2.Location = New System.Drawing.Point(104, 32)
        Me._txtcampo_2.MaxLength = 4
        Me._txtcampo_2.Name = "_txtcampo_2"
        Me._txtcampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_2.Size = New System.Drawing.Size(71, 20)
        Me._txtcampo_2.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_2, "")
        '
        '_txtcampo_1
        '
        Me._txtcampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_1, False)
        Me._txtcampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_1, "Default")
        Me._txtcampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_1.Location = New System.Drawing.Point(104, 8)
        Me._txtcampo_1.MaxLength = 4
        Me._txtcampo_1.Name = "_txtcampo_1"
        Me._txtcampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_1.Size = New System.Drawing.Size(71, 20)
        Me._txtcampo_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_1, "")
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
        Me._cmdBoton_5.Location = New System.Drawing.Point(-100, 89)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 11
        Me._cmdBoton_5.Tag = "6335"
        Me._cmdBoton_5.Text = "*&Imprimir"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
        '
        '_txtcampo_0
        '
        Me._txtcampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_0, False)
        Me._txtcampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_0, "Default")
        Me._txtcampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_0.Location = New System.Drawing.Point(104, 82)
        Me._txtcampo_0.MaxLength = 15
        Me._txtcampo_0.Name = "_txtcampo_0"
        Me._txtcampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_0.Size = New System.Drawing.Size(141, 20)
        Me._txtcampo_0.TabIndex = 3
        Me._txtcampo_0.Text = "0.00"
        Me._txtcampo_0.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_0, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 254)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 6
        Me._cmdBoton_4.Text = "*&Limpiar"
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
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 152)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 4
        Me._cmdBoton_1.Text = "*Sig&tes."
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 203)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 5
        Me._cmdBoton_2.Text = "*&Transmitir"
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 305)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 7
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdOperaciones
        '
        Me.grdOperaciones._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdOperaciones, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdOperaciones, False)
        Me.grdOperaciones.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdOperaciones.Clip = ""
        Me.grdOperaciones.Col = CType(1, Short)
        Me.grdOperaciones.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdOperaciones.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdOperaciones.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdOperaciones, "Default")
        Me.grdOperaciones.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdOperaciones, True)
        Me.grdOperaciones.FixedCols = CType(1, Short)
        Me.grdOperaciones.FixedRows = CType(1, Short)
        Me.grdOperaciones.ForeColor = System.Drawing.Color.Black
        Me.grdOperaciones.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdOperaciones.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdOperaciones.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdOperaciones.HighLight = True
        Me.grdOperaciones.Location = New System.Drawing.Point(6, 19)
        Me.grdOperaciones.Name = "grdOperaciones"
        Me.grdOperaciones.Picture = Nothing
        Me.grdOperaciones.Row = CType(1, Short)
        Me.grdOperaciones.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdOperaciones.Size = New System.Drawing.Size(554, 223)
        Me.grdOperaciones.Sort = CType(2, Short)
        Me.grdOperaciones.TabIndex = 9
        Me.grdOperaciones.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdOperaciones, "")
        '
        '_lbletiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_7, False)
        Me._lbletiqueta_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lbletiqueta_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_7, "Default")
        Me._lbletiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_7.Location = New System.Drawing.Point(178, 32)
        Me._lbletiqueta_7.Name = "_lbletiqueta_7"
        Me._lbletiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_7.Size = New System.Drawing.Size(399, 20)
        Me._lbletiqueta_7.TabIndex = 17
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_7, "")
        '
        '_lbletiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_6, False)
        Me._lbletiqueta_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lbletiqueta_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_6, "Default")
        Me._lbletiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_6.Location = New System.Drawing.Point(178, 8)
        Me._lbletiqueta_6.Name = "_lbletiqueta_6"
        Me._lbletiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_6.Size = New System.Drawing.Size(399, 20)
        Me._lbletiqueta_6.TabIndex = 16
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_6, "")
        '
        '_lbletiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_5, False)
        Me._lbletiqueta_5.AutoSize = True
        Me._lbletiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_5, "Default")
        Me._lbletiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_5.Location = New System.Drawing.Point(10, 10)
        Me._lbletiqueta_5.Name = "_lbletiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_5, "508723")
        Me._lbletiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_5.Size = New System.Drawing.Size(70, 13)
        Me._lbletiqueta_5.TabIndex = 15
        Me._lbletiqueta_5.Text = "*Territorial:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_5, "")
        '
        '_lbletiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_4, False)
        Me._lbletiqueta_4.AutoSize = True
        Me._lbletiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_4, "Default")
        Me._lbletiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_4.Location = New System.Drawing.Point(10, 33)
        Me._lbletiqueta_4.Name = "_lbletiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_4, "500873")
        Me._lbletiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_4.Size = New System.Drawing.Size(45, 13)
        Me._lbletiqueta_4.TabIndex = 14
        Me._lbletiqueta_4.Text = "*Zona:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_4, "")
        '
        '_lbletiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_2, False)
        Me._lbletiqueta_2.AutoSize = True
        Me._lbletiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_2, "Default")
        Me._lbletiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_2.Location = New System.Drawing.Point(10, 58)
        Me._lbletiqueta_2.Name = "_lbletiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_2, "500367")
        Me._lbletiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_2.Size = New System.Drawing.Size(62, 13)
        Me._lbletiqueta_2.TabIndex = 13
        Me._lbletiqueta_2.Text = "*Agencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_2, "")
        '
        '_lbletiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_3, False)
        Me._lbletiqueta_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lbletiqueta_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_3, "Default")
        Me._lbletiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_3.Location = New System.Drawing.Point(178, 57)
        Me._lbletiqueta_3.Name = "_lbletiqueta_3"
        Me._lbletiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_3.Size = New System.Drawing.Size(399, 20)
        Me._lbletiqueta_3.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_3, "")
        '
        '_lbletiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbletiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbletiqueta_0, False)
        Me._lbletiqueta_0.AutoSize = True
        Me._lbletiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbletiqueta_0, "Default")
        Me._lbletiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbletiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lbletiqueta_0.Location = New System.Drawing.Point(10, 85)
        Me._lbletiqueta_0.Name = "_lbletiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lbletiqueta_0, "500027")
        Me._lbletiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbletiqueta_0.Size = New System.Drawing.Size(51, 13)
        Me._lbletiqueta_0.TabIndex = 8
        Me._lbletiqueta_0.Text = "*Monto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbletiqueta_0, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._txtcampo_3)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lbletiqueta_5)
        Me.PFormas.Controls.Add(Me._txtcampo_2)
        Me.PFormas.Controls.Add(Me._lbletiqueta_0)
        Me.PFormas.Controls.Add(Me._txtcampo_1)
        Me.PFormas.Controls.Add(Me._lbletiqueta_3)
        Me.PFormas.Controls.Add(Me._txtcampo_0)
        Me.PFormas.Controls.Add(Me._lbletiqueta_2)
        Me.PFormas.Controls.Add(Me._lbletiqueta_4)
        Me.PFormas.Controls.Add(Me._lbletiqueta_6)
        Me.PFormas.Controls.Add(Me._lbletiqueta_7)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(594, 363)
        Me.PFormas.TabIndex = 18
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        '_txtcampo_3
        '
        Me._txtcampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtcampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtcampo_3, False)
        Me._txtcampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtcampo_3, "Default")
        Me._txtcampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtcampo_3.Location = New System.Drawing.Point(104, 57)
        Me._txtcampo_3.MaxLength = 4
        Me._txtcampo_3.Name = "_txtcampo_3"
        Me._txtcampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtcampo_3.Size = New System.Drawing.Size(71, 20)
        Me._txtcampo_3.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtcampo_3, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdOperaciones)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 108)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "500395")
        Me.GroupBox1.Size = New System.Drawing.Size(567, 251)
        Me.GroupBox1.TabIndex = 18
        Me.GroupBox1.Text = "*Listado de las Operaciones:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBImprimir, Me.TSBSiguientes, Me.TSBBuscar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(615, 25)
        Me.TSBotones.TabIndex = 19
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Navy
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Navy
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'Ftran302Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(190, 311)
        Me.Name = "Ftran302Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(615, 408)
        Me.Tag = "3067"
        Me.Text = "*Consulta de Operaciones Superiores a un monto en Cuentas de Ahorros"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdOperaciones, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub Initializetxtcampo()
        Me.txtcampo(3) = _txtcampo_3
        Me.txtcampo(2) = _txtcampo_2
        Me.txtcampo(1) = _txtcampo_1
        Me.txtcampo(0) = _txtcampo_0
    End Sub
    Sub Initializelbletiqueta()
        Me.lbletiqueta(7) = _lbletiqueta_7
        Me.lbletiqueta(6) = _lbletiqueta_6
        Me.lbletiqueta(5) = _lbletiqueta_5
        Me.lbletiqueta(4) = _lbletiqueta_4
        Me.lbletiqueta(2) = _lbletiqueta_2
        Me.lbletiqueta(3) = _lbletiqueta_3
        'Me.lbletiqueta(1) = _lbletiqueta_1
        Me.lbletiqueta(0) = _lbletiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub

    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


