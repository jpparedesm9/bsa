<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAyudaClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializecmdSeleccion()
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
    Private WithEvents _cmdSeleccion_3 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_2 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_1 As System.Windows.Forms.Button
    Private WithEvents _cmdSeleccion_0 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Public cmdSeleccion(3) As System.Windows.Forms.Button
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAyudaClass))
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me._cmdSeleccion_3 = New System.Windows.Forms.Button
        Me._cmdSeleccion_2 = New System.Windows.Forms.Button
        Me._cmdSeleccion_1 = New System.Windows.Forms.Button
        Me._cmdSeleccion_0 = New System.Windows.Forms.Button
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton
        Me.TSBEscoger = New System.Windows.Forms.ToolStripButton
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pforma.SuspendLayout()
        Me.SuspendLayout()
        Me.COBISViewResizer.ContainerForm = Me
        '
        'Pforma
        '
        Me.Pforma.Controls.Add(Me.TSBotones)
        Me.Pforma.Controls.Add(Me.grdRegistros)
        Me.Pforma.Controls.Add(Me._cmdSeleccion_1)
        Me.Pforma.Controls.Add(Me._cmdSeleccion_0)
        Me.Pforma.Controls.Add(Me._cmdSeleccion_3)
        Me.Pforma.Controls.Add(Me._cmdSeleccion_2)
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(385, 305)
        Me.Pforma.TabIndex = 0
        Me.Pforma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        '
        'COBISResourceProvider
        '
        Me.COBISResourceProvider.SetImageID(Me.COBISResourceProvider, "")
        Me.COBISResourceProvider.SetResourceID(Me.COBISResourceProvider, "")
        '
        'ToolTip1
        '
        Me.COBISResourceProvider.SetImageID(Me.ToolTip1, "")
        Me.COBISResourceProvider.SetResourceID(Me.ToolTip1, "")
        '
        '_cmdSeleccion_3
        '
        Me._cmdSeleccion_3.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_3, True)
        Me._cmdSeleccion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_3, Nothing)
        Me._cmdSeleccion_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_3.Image = CType(resources.GetObject("_cmdSeleccion_3.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdSeleccion_3, "")
        Me._cmdSeleccion_3.Location = New System.Drawing.Point(281, 196)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_3, System.Drawing.Color.Silver)
        Me._cmdSeleccion_3.Name = "_cmdSeleccion_3"
        Me.COBISResourceProvider.SetResourceID(Me._cmdSeleccion_3, "")
        Me._cmdSeleccion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_3.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_3, 1)
        Me._cmdSeleccion_3.TabIndex = 4
        Me._cmdSeleccion_3.Text = "&Salir"
        Me._cmdSeleccion_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_3.UseVisualStyleBackColor = True
        '
        '_cmdSeleccion_2
        '
        Me._cmdSeleccion_2.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_2, True)
        Me._cmdSeleccion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_2, Nothing)
        Me._cmdSeleccion_2.Enabled = False
        Me._cmdSeleccion_2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_2.Image = CType(resources.GetObject("_cmdSeleccion_2.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdSeleccion_2, "")
        Me._cmdSeleccion_2.Location = New System.Drawing.Point(281, 137)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_2, System.Drawing.Color.Silver)
        Me._cmdSeleccion_2.Name = "_cmdSeleccion_2"
        Me.COBISResourceProvider.SetResourceID(Me._cmdSeleccion_2, "")
        Me._cmdSeleccion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_2.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_2, 1)
        Me._cmdSeleccion_2.TabIndex = 3
        Me._cmdSeleccion_2.Text = "&Escoger"
        Me._cmdSeleccion_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_2.UseVisualStyleBackColor = True
        '
        '_cmdSeleccion_1
        '
        Me._cmdSeleccion_1.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_1, True)
        Me._cmdSeleccion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_1, Nothing)
        Me._cmdSeleccion_1.Enabled = False
        Me._cmdSeleccion_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_1.Image = CType(resources.GetObject("_cmdSeleccion_1.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdSeleccion_1, "")
        Me._cmdSeleccion_1.Location = New System.Drawing.Point(151, 111)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_1, System.Drawing.Color.Silver)
        Me._cmdSeleccion_1.Name = "_cmdSeleccion_1"
        Me.COBISResourceProvider.SetResourceID(Me._cmdSeleccion_1, "")
        Me._cmdSeleccion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_1.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_1, 1)
        Me._cmdSeleccion_1.TabIndex = 2
        Me._cmdSeleccion_1.Text = "Sig&tes."
        Me._cmdSeleccion_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_1.UseVisualStyleBackColor = True
        '
        '_cmdSeleccion_0
        '
        Me._cmdSeleccion_0.BackColor = System.Drawing.SystemColors.Control
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdSeleccion_0, True)
        Me._cmdSeleccion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdSeleccion_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdSeleccion_0, Nothing)
        Me._cmdSeleccion_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdSeleccion_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdSeleccion_0.Image = CType(resources.GetObject("_cmdSeleccion_0.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me._cmdSeleccion_0, "")
        Me._cmdSeleccion_0.Location = New System.Drawing.Point(151, 52)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdSeleccion_0, System.Drawing.Color.Silver)
        Me._cmdSeleccion_0.Name = "_cmdSeleccion_0"
        Me.COBISResourceProvider.SetResourceID(Me._cmdSeleccion_0, "")
        Me._cmdSeleccion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdSeleccion_0.Size = New System.Drawing.Size(58, 58)
        Me.commandButtonHelper1.SetStyle(Me._cmdSeleccion_0, 1)
        Me._cmdSeleccion_0.TabIndex = 1
        Me._cmdSeleccion_0.Text = "&Buscar"
        Me._cmdSeleccion_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdSeleccion_0.UseVisualStyleBackColor = True
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(240,246,250)
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdRegistros.CtlText = ""
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.COBISResourceProvider.SetImageID(Me.grdRegistros, "")
        Me.grdRegistros.Location = New System.Drawing.Point(10, 35)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.COBISResourceProvider.SetResourceID(Me.grdRegistros, "")
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(365, 235)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 0
        Me.grdRegistros.TopRow = CType(1, Short)
        '
        'commandButtonHelper1
        '
        Me.COBISResourceProvider.SetImageID(Me.commandButtonHelper1, "")
        Me.COBISResourceProvider.SetResourceID(Me.commandButtonHelper1, "")
        '
        'TSBotones
        '
        Me.COBISResourceProvider.SetImageID(Me.TSBotones, "")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBEscoger, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.COBISResourceProvider.SetResourceID(Me.TSBotones, "")
        Me.TSBotones.Size = New System.Drawing.Size(375, 25)
        Me.TSBotones.TabIndex = 5
        Me.TSBotones.Text = "ToolStrip1"
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "")
        Me.TSBBuscar.Size = New System.Drawing.Size(65, 22)
        Me.TSBBuscar.Text = "*Buscar"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "")
        Me.TSBSiguientes.Size = New System.Drawing.Size(82, 22)
        Me.TSBSiguientes.Text = "*Siguientes"
        '
        'TSBEscoger
        '
        Me.TSBEscoger.ForeColor = System.Drawing.Color.Black
        Me.TSBEscoger.Image = CType(resources.GetObject("TSBEscoger.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEscoger, "")
        Me.TSBEscoger.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEscoger.Name = "TSBEscoger"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEscoger, "")
        Me.TSBEscoger.Size = New System.Drawing.Size(71, 22)
        Me.TSBEscoger.Text = "*Escoger"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*Salir"
        '
        'FAyuda
        '
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.ClientSize = New System.Drawing.Size(375, 275)
        Me.Controls.Add(Me.Pforma)
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.COBISResourceProvider.SetImageID(Me, "")
        Me.Location = New System.Drawing.Point(61, 113)
        Me.Name = "FAyuda"
        Me.COBISResourceProvider.SetResourceID(Me, "")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Text = "Lista de Registros"
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pforma.ResumeLayout(False)
        Me.Pforma.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializecmdSeleccion()
        Me.cmdSeleccion(3) = _cmdSeleccion_3
        Me.cmdSeleccion(2) = _cmdSeleccion_2
        Me.cmdSeleccion(1) = _cmdSeleccion_1
        Me.cmdSeleccion(0) = _cmdSeleccion_0
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEscoger As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class


