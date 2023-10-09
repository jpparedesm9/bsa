<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FAyudaSubserv2Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializecmdBuscar()
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
    Public WithEvents cmdSalir As System.Windows.Forms.Button
    Public WithEvents cmdEscoger As System.Windows.Forms.Button
    Private WithEvents _cmdBuscar_0 As System.Windows.Forms.Button
    Public WithEvents grdSubserv As COBISCorp.Framework.UI.Components.COBISGrid
    Public cmdBuscar(0) As System.Windows.Forms.Button
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAyudaSubserv2Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.cmdSalir = New System.Windows.Forms.Button()
        Me.cmdEscoger = New System.Windows.Forms.Button()
        Me._cmdBuscar_0 = New System.Windows.Forms.Button()
        Me.grdSubserv = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdSubserv, System.ComponentModel.ISupportInitialize).BeginInit()
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
        'cmdSalir
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdSalir, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdSalir, False)
        Me.cmdSalir.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdSalir, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdSalir, True)
        Me.cmdSalir.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdSalir, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdSalir, Nothing)
        Me.cmdSalir.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdSalir.Image = CType(resources.GetObject("cmdSalir.Image"), System.Drawing.Image)
        Me.cmdSalir.Location = New System.Drawing.Point(-457, 226)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdSalir, System.Drawing.Color.Silver)
        Me.cmdSalir.Name = "cmdSalir"
        Me.cmdSalir.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdSalir.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdSalir, 1)
        Me.cmdSalir.TabIndex = 3
        Me.cmdSalir.Text = "&Salir"
        Me.cmdSalir.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdSalir.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdSalir.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdSalir, "")
        '
        'cmdEscoger
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmdEscoger, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmdEscoger, False)
        Me.cmdEscoger.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.cmdEscoger, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me.cmdEscoger, True)
        Me.cmdEscoger.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me.cmdEscoger, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me.cmdEscoger, Nothing)
        Me.cmdEscoger.Enabled = False
        Me.cmdEscoger.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdEscoger.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdEscoger.Image = CType(resources.GetObject("cmdEscoger.Image"), System.Drawing.Image)
        Me.cmdEscoger.Location = New System.Drawing.Point(-457, 175)
        Me.commandButtonHelper1.SetMaskColor(Me.cmdEscoger, System.Drawing.Color.Silver)
        Me.cmdEscoger.Name = "cmdEscoger"
        Me.cmdEscoger.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdEscoger.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me.cmdEscoger, 1)
        Me.cmdEscoger.TabIndex = 2
        Me.cmdEscoger.Text = "&Escoger"
        Me.cmdEscoger.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.cmdEscoger.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me.cmdEscoger.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmdEscoger, "")
        '
        '_cmdBuscar_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBuscar_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBuscar_0, False)
        Me._cmdBuscar_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBuscar_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBuscar_0, True)
        Me._cmdBuscar_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBuscar_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBuscar_0, Nothing)
        Me._cmdBuscar_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBuscar_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBuscar_0.Image = CType(resources.GetObject("_cmdBuscar_0.Image"), System.Drawing.Image)
        Me._cmdBuscar_0.Location = New System.Drawing.Point(-457, 124)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBuscar_0, System.Drawing.Color.Silver)
        Me._cmdBuscar_0.Name = "_cmdBuscar_0"
        Me._cmdBuscar_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBuscar_0.Size = New System.Drawing.Size(60, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBuscar_0, 1)
        Me._cmdBuscar_0.TabIndex = 1
        Me._cmdBuscar_0.Text = "&Buscar"
        Me._cmdBuscar_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBuscar_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBuscar_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBuscar_0, "")
        '
        'grdSubserv
        '
        Me.grdSubserv._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdSubserv, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdSubserv, False)
        Me.grdSubserv.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdSubserv.Clip = ""
        Me.grdSubserv.Col = CType(1, Short)
        Me.grdSubserv.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdSubserv.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdSubserv.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdSubserv, "Default")
        Me.grdSubserv.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdSubserv, True)
        Me.grdSubserv.FixedCols = CType(1, Short)
        Me.grdSubserv.FixedRows = CType(1, Short)
        Me.grdSubserv.ForeColor = System.Drawing.Color.Black
        Me.grdSubserv.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdSubserv.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdSubserv.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdSubserv.HighLight = True
        Me.grdSubserv.Location = New System.Drawing.Point(10, 20)
        Me.grdSubserv.Name = "grdSubserv"
        Me.grdSubserv.Picture = Nothing
        Me.grdSubserv.Row = CType(1, Short)
        Me.grdSubserv.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdSubserv.Size = New System.Drawing.Size(434, 247)
        Me.grdSubserv.Sort = CType(2, Short)
        Me.grdSubserv.TabIndex = 0
        Me.grdSubserv.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdSubserv, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(466, 288)
        Me.PFormas.TabIndex = 5
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.Transparent
        Me.GroupBox1.Controls.Add(Me.grdSubserv)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "1442")
        Me.GroupBox1.Size = New System.Drawing.Size(450, 272)
        Me.GroupBox1.TabIndex = 5
        Me.GroupBox1.Text = "*Lista de Rubros de Servicios:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(482, 25)
        Me.TSBotones.TabIndex = 6
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
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "30002")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "1325")
        Me.TSBEscoger.Size = New System.Drawing.Size(73, 22)
        Me.TSBEscoger.Text = "*Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'FAyudaSubserv2Class
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
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(65, 141)
        Me.Name = "FAyudaSubserv2Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(482, 328)
        Me.Text = "Búsqueda Rubros de Servicios"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdSubserv, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializecmdBuscar()
        Me.cmdBuscar(0) = _cmdBuscar_0
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class


