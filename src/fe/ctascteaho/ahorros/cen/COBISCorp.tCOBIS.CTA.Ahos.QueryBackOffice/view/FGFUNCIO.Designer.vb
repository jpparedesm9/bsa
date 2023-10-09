Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FGFuncionariosClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializeoptOpcion()
        InitializelblTitulo()
        InitializecmdBoton()
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
    Public WithEvents txtCampo As System.Windows.Forms.TextBox
    Private WithEvents _optOpcion_3 As System.Windows.Forms.RadioButton
    Private WithEvents _optOpcion_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optOpcion_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optOpcion_0 As System.Windows.Forms.RadioButton
    Public WithEvents grdFuncionarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _lblTitulo_3 As System.Windows.Forms.Label
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblTitulo(3) As System.Windows.Forms.Label
    Public linLinea(2) As System.Windows.Forms.Label
    Public optOpcion(3) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FGFuncionariosClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.txtCampo = New System.Windows.Forms.TextBox()
        Me._optOpcion_3 = New System.Windows.Forms.RadioButton()
        Me._optOpcion_2 = New System.Windows.Forms.RadioButton()
        Me._optOpcion_1 = New System.Windows.Forms.RadioButton()
        Me._optOpcion_0 = New System.Windows.Forms.RadioButton()
        Me.grdFuncionarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._lblTitulo_3 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GBFuncionarios = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdFuncionarios, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.GBFuncionarios, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GBFuncionarios.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
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
        'txtCampo
        '
        Me.txtCampo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCampo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCampo, False)
        Me.txtCampo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCampo, "Default")
        Me.txtCampo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCampo.Location = New System.Drawing.Point(10, 25)
        Me.txtCampo.MaxLength = 30
        Me.txtCampo.Name = "txtCampo"
        Me.COBISResourceProvider.SetResourceID(Me.txtCampo, "500227")
        Me.txtCampo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCampo.Size = New System.Drawing.Size(231, 20)
        Me.txtCampo.TabIndex = 4
        Me.txtCampo.Text = "*OFI%"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCampo, "")
        '
        '_optOpcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_3, False)
        Me._optOpcion_3.AutoSize = True
        Me._optOpcion_3.BackColor = System.Drawing.Color.Transparent
        Me._optOpcion_3.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_3, "Default")
        Me._optOpcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOpcion_3.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_3.Location = New System.Drawing.Point(90, 38)
        Me._optOpcion_3.Name = "_optOpcion_3"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_3, "500228")
        Me._optOpcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_3.Size = New System.Drawing.Size(57, 17)
        Me._optOpcion_3.TabIndex = 3
        Me._optOpcion_3.TabStop = True
        Me._optOpcion_3.Text = "*Cargo"
        Me._optOpcion_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_3, "")
        '
        '_optOpcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_2, False)
        Me._optOpcion_2.AutoSize = True
        Me._optOpcion_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_2, "Default")
        Me._optOpcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOpcion_2.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_2.Location = New System.Drawing.Point(90, 19)
        Me._optOpcion_2.Name = "_optOpcion_2"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_2, "500229")
        Me._optOpcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_2.Size = New System.Drawing.Size(55, 17)
        Me._optOpcion_2.TabIndex = 2
        Me._optOpcion_2.Text = "*Login"
        Me._optOpcion_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_2, "")
        '
        '_optOpcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_1, False)
        Me._optOpcion_1.AutoSize = True
        Me._optOpcion_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_1, "Default")
        Me._optOpcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOpcion_1.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_1.Location = New System.Drawing.Point(6, 38)
        Me._optOpcion_1.Name = "_optOpcion_1"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_1, "2401")
        Me._optOpcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_1.Size = New System.Drawing.Size(66, 17)
        Me._optOpcion_1.TabIndex = 1
        Me._optOpcion_1.Text = "*Nombre"
        Me._optOpcion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_1, "")
        '
        '_optOpcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOpcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOpcion_0, False)
        Me._optOpcion_0.AutoSize = True
        Me._optOpcion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOpcion_0, "Default")
        Me._optOpcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOpcion_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOpcion_0.ForeColor = System.Drawing.Color.Navy
        Me._optOpcion_0.Location = New System.Drawing.Point(6, 19)
        Me._optOpcion_0.Name = "_optOpcion_0"
        Me.COBISResourceProvider.SetResourceID(Me._optOpcion_0, "500230")
        Me._optOpcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOpcion_0.Size = New System.Drawing.Size(62, 17)
        Me._optOpcion_0.TabIndex = 0
        Me._optOpcion_0.Text = "*Código"
        Me._optOpcion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOpcion_0, "")
        '
        'grdFuncionarios
        '
        Me.grdFuncionarios._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdFuncionarios, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdFuncionarios, False)
        Me.grdFuncionarios.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdFuncionarios.Clip = ""
        Me.grdFuncionarios.Col = CType(1, Short)
        Me.grdFuncionarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdFuncionarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdFuncionarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdFuncionarios, "Default")
        Me.grdFuncionarios.CtlText = ""
        Me.grdFuncionarios.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdFuncionarios, True)
        Me.grdFuncionarios.FixedCols = CType(1, Short)
        Me.grdFuncionarios.FixedRows = CType(1, Short)
        Me.grdFuncionarios.ForeColor = System.Drawing.Color.Black
        Me.grdFuncionarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdFuncionarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdFuncionarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdFuncionarios.HighLight = True
        Me.grdFuncionarios.Location = New System.Drawing.Point(3, 16)
        Me.grdFuncionarios.Name = "grdFuncionarios"
        Me.grdFuncionarios.Picture = Nothing
        Me.grdFuncionarios.Row = CType(1, Short)
        Me.grdFuncionarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdFuncionarios.Size = New System.Drawing.Size(417, 183)
        Me.grdFuncionarios.Sort = CType(2, Short)
        Me.grdFuncionarios.TabIndex = 5
        Me.grdFuncionarios.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdFuncionarios, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-496, 1)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 6
        Me._cmdBoton_0.Text = "*&Buscar"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-496, 52)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 7
        Me._cmdBoton_1.Text = "*Si&guiente"
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-496, 245)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 9
        Me._cmdBoton_4.Text = "*&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-496, 194)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 8
        Me._cmdBoton_2.Text = "*&Escoger"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_lblTitulo_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblTitulo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblTitulo_3, False)
        Me._lblTitulo_3.AutoSize = True
        Me._lblTitulo_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblTitulo_3, "Default")
        Me._lblTitulo_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblTitulo_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblTitulo_3.ForeColor = System.Drawing.Color.Navy
        Me._lblTitulo_3.Location = New System.Drawing.Point(118, 1)
        Me._lblTitulo_3.Name = "_lblTitulo_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblTitulo_3, "500232")
        Me._lblTitulo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblTitulo_3.Size = New System.Drawing.Size(59, 13)
        Me._lblTitulo_3.TabIndex = 13
        Me._lblTitulo_3.Text = "*[Código] : "
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblTitulo_3, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.GBFuncionarios)
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(444, 290)
        Me.PFormas.TabIndex = 17
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me._lblTitulo_3)
        Me.UltraGroupBox2.Controls.Add(Me.txtCampo)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(182, 10)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox2, "500233")
        Me.UltraGroupBox2.Size = New System.Drawing.Size(251, 62)
        Me.UltraGroupBox2.TabIndex = 20
        Me.UltraGroupBox2.Text = "*Valor de Búsqueda "
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'GBFuncionarios
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GBFuncionarios, False)
        Me.COBISViewResizer.SetAutoResize(Me.GBFuncionarios, False)
        Me.GBFuncionarios.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GBFuncionarios.Controls.Add(Me.grdFuncionarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GBFuncionarios, "Default")
        Me.GBFuncionarios.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GBFuncionarios.ForeColor = System.Drawing.Color.Navy
        Me.GBFuncionarios.Location = New System.Drawing.Point(10, 78)
        Me.GBFuncionarios.Name = "GBFuncionarios"
        Me.COBISResourceProvider.SetResourceID(Me.GBFuncionarios, "500235")
        Me.GBFuncionarios.Size = New System.Drawing.Size(423, 202)
        Me.GBFuncionarios.TabIndex = 14
        Me.GBFuncionarios.Text = "*Funcionarios"
        Me.GBFuncionarios.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GBFuncionarios, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me._optOpcion_2)
        Me.UltraGroupBox1.Controls.Add(Me._optOpcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._optOpcion_3)
        Me.UltraGroupBox1.Controls.Add(Me._optOpcion_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.UltraGroupBox1, "500234")
        Me.UltraGroupBox1.Size = New System.Drawing.Size(166, 62)
        Me.UltraGroupBox1.TabIndex = 19
        Me.UltraGroupBox1.Text = "*Condición de Búsqueda :"
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(464, 25)
        Me.TSBotones.TabIndex = 18
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
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
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "2002")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*&Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FGFuncionariosClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(34, 85)
        Me.Name = "FGFuncionariosClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(464, 336)
        Me.Text = "Listado General de Funcionarios"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdFuncionarios, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        Me.UltraGroupBox2.PerformLayout()
        CType(Me.GBFuncionarios, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GBFuncionarios.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptOpcion()
        Me.optOpcion(3) = _optOpcion_3
        Me.optOpcion(2) = _optOpcion_2
        Me.optOpcion(1) = _optOpcion_1
        Me.optOpcion(0) = _optOpcion_0
    End Sub
    Sub InitializelblTitulo()
        Me.lblTitulo(3) = _lblTitulo_3
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GBFuncionarios As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


