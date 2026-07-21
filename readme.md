# Deans-Office-LaTeX (教务处风格文档模板)

为什么学校发的各种word模板总喜欢用一个大表格装着？

> 一个用于生成“高校教务处风格”文档的 LaTeX 模板。
> 满足那种全文都在一个大表格里、有复杂表头、正文需要跨页的奇妙Word模板的LaTeX排版。

## `main.tex`编译效果示例

> 示例截图已过时。请自行编译 `main.tex` 查看最新效果。

## 简介

在我们学校的毕业设计报告、实验报告或别的什么东西中，经常遇到一种 LaTeX 很难排出来的、像在一个巨大的封闭表格中的Word模板文档需要填写。当我需要输入公式时，总是想使用LaTeX编写一个类似的文档，但LaTeX传统的 `tabular` 无法跨页，`longtable` 不支持单元格内复杂的图文混排。

本repo的解决思路是做个假的表格：

1.  利用 `TikZ` 和 `atbegshi` 在每一页生成边框，然后再插入分隔线，使其看起来就像是一个表格。
2.  正文区域本质上是普通的文本流，可以随意分段、插入公式、列表，不再受限于表格单元格。

## 编译与使用

所有代码均包含在[`main.tex`](./main.tex)中。

仅在XeLaTeX下编译测试通过。

```bash
xelatex main.tex
```

**注意**：由于涉及到 `TikZ` 的绝对定位绘制，页面布局或内容发生更改时，通常需要**编译两次**，边框线才能显示在正确的位置。

## 核心命令说明

### 全局配置

在导言区修改以下参数，即可改变整个文档的结构：

```latex
\setlength{\PageMargin}{1in}  % 边框距离纸张边缘的距离
\setlength{\RowHeight}{1.2em}   % 表格行的最小高度
\def\GlobalLineWidth{0.5pt}     % 外框粗细
```

### 页面外框 (`TablePage` / `TablePages`)

模板提供两种外框环境：

- **`TablePages`**：多页跨页表格。内容可以且必须跨页，每页自动绘制外框。
- **`TablePage`**：单页闭合框。在当前页内画完整闭合框，内容必须在一页内。

```latex
% 多页版本：用于正文较长、会跨页的内容
\begin{TablePages}
    {\centering\bfseries\LARGE 标题 \par}
    \vspace{0.5em}
    \SepLine
    正文内容...
\end{TablePages}

% 单页版本：用于一页内能装下的内容
\begin{TablePage}
    这里的内容在当前页画闭合框。
\end{TablePage}
```

### 生成表格行 (`\TableRow`)

类似 `tabularx` 的语法，但会自动画好上边缘和下边缘的线并撑满版心：

```latex
% 语法: \TableRow{列格式}{内容...}
% X = 自动宽度, c = 居中, | = 竖线

\TableRow{ c | X | c | X }{
    \textbf{姓名} & 张三 & \textbf{学号} & 2023001
}
```

### 跨页长文本 (自由流)

对于需要跨页的大段文本，直接写即可。

```latex
\begin{TablePages}
    \TableRow{l}{\textbf{一、研究内容}} % 标题行

    这里是正文...可以写很长...可以跨页...
    \begin{itemize}
      \item 支持列表
      \item 支持公式 $E=mc^2$
    \end{itemize}
\end{TablePages}
```

### 定高文本框 (`LongTextField`)

用于模拟 Word 中那种固定高度的文本框（例如留给手写签字的区域，或者要求"本栏主要填写XX内容"）。

```latex
% 语法: \begin{LongTextField}[高度] ... \end{LongTextField}
% 默认高度 5cm

\begin{LongTextField}[8cm]
    这里预留了8cm的高度。
    适合打印出来后手写填写。
\end{LongTextField}
```

### 侧边栏排版 (`SidebarTablePage` / `SidebarTablePages`)

在表格左侧添加侧边栏，主体内容向右缩进。侧边栏内居中显示标题。

```latex
% 单页版：内容必须放在一页内。竖线从内容起始位置画到结束位置。
% 语法: \begin{SidebarTablePage}{侧边栏宽度}{标题内容}
%       ...主体内容...
%       \end{SidebarTablePage}

\begin{SidebarTablePage}{2cm}{
    \centering
    这里写
    侧边栏标题
  }
  这里是主体内容，必须能在一页内装下。
\end{SidebarTablePage}

% 多页版：内容可以跨页。每页自动绘制侧边栏竖线。
% 语法: \begin{SidebarTablePages}{侧边栏宽度}{标题内容}
%       ...主体内容...
%       \end{SidebarTablePages}

\begin{SidebarTablePages}{1cm}{
    \centering
    跨页侧边栏
  }
  \lipsum[1-8] % 会跨越多页，每页都有竖线
\end{SidebarTablePages}
```

### 其他排版控制

- `\vspaceSepLine`: 画一条分割线。

具体使用示例以及效果请查看[`main.tex`](./main.tex)文件。

## License

MIT License.

你可以随意修改此模板用于你的毕业论文、开题报告或作业。
