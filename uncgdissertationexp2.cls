%Time-stamp: "Last modified: 2020-09-15 15:40:29 (d_yasaki)"
% indent every paragraph
%fixed spacing in toc for bibliography and appendix.  07272018
% Fixed vertical spacing on Bibliography page 0802018
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uncgdissertationexp}[2018/04/23 Experimental LaTeX
  class for UNCG dissertation]
\LoadClass[oneside, openany, 12pt, onecolumn, final]{book}
\RequirePackage[tableposition=top, labelsep = period]{caption}
%\RequirePackage[section, below]{placeins}
\RequirePackage{etoolbox}
\RequirePackage{calc}
\RequirePackage{titlesec}
\RequirePackage[dotinlabels, rightlabels]{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lastpage}  % to count pages
\RequirePackage{setspace}  % to do doublespace
\RequirePackage[overload]{textcase} % So that math does not get
                                % capitalized in
                          % chapter titles.  Note that the overload
                          % option is used, so this redefines
                          % \MakeUppercase 
\RequirePackage[noadjust]{cite}
\RequirePackage{indentfirst}  % if you want to indent first paragraph of a chapter.
\RequirePackage[T1]{fontenc}
\RequirePackage[top = 1.5in, right = 1in, left =  1.5in]{geometry}  % to set margins

%\RequirePackage{parskip}  % no indention on paragraphs.
\RequirePackage[nottoc]{tocbibind} % Put bibliography in TOC

\newif\if@MA  % Masters MA thesis format
\newif\if@MS  % Masters MS thesis format
\newif\if@PHD  % PhD dissertation format

\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \xleaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill%
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}


\newcommand{\uncg@thesistype}{ms}
\DeclareOption{phd}{\renewcommand{\uncg@thesistype}{phd} \@MAfalse
  \@MSfalse \@PHDtrue}
\DeclareOption{ma}{\renewcommand{\uncg@thesistype}{ma} \@MAtrue
  \@MSfalse \@PHDfalse}
\DeclareOption{ms}{\renewcommand{\uncg@thesistype}{ms} \@MStrue
  \@MAfalse \@PHDfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax  

%% Modified by Larry Joshua Crotts - added roman numerals and changed format to be \large, without bold, and upper-cased words/chapter names.
\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thefigure}{\arabic{figure}}
\titleformat{\chapter}[block]{\centering\large}{CHAPTER \thechapter\\}{6pt}{\uppercase}

\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{References}



%\contentsmargin[4em]{18pt}  % sets how far the multiline section
                            % titles can come over and also the
                            % distance the leaders stay from the page
                            % numbers. 

%-----------------------------------------------------------------------------
% Count the number of co-chairs 
\newcounter{@chair}           % Number of chairs defined so far.
\setcounter{@chair}{0}        
\newcommand{\chair}[1]{
  \addtocounter{@chair}{1}    % Inc. num of classes to include this
                              % new one.
  \ifcase\value{@chair}
   \or \newcommand{\uncg@chair}{#1}
    \or \newcommand{\uncg@cochair}{#1}
  \else
     \ClassError{uncgdissertation.cls}
        {Committee error.  Too many chairs.}
  \fi
}
%-----------------------------------------------------------------------------
%-----------------------------------------------------------------------------
% Count the number of members (not including chair)
\newcounter{@member}           % Number of members defined so far.
\setcounter{@member}{0}        
\newcommand{\member}[1]{
  \addtocounter{@member}{1}    % Inc. num of classes to include this
                               % new one.
  \ifcase\value{@member}
   \or \newcommand{\uncg@memberI}{#1}
    \or \newcommand{\uncg@memberII}{#1}
     \or \newcommand{\uncg@memberIII}{#1}
      \or \newcommand{\uncg@memberIV}{#1}
       \or \newcommand{\uncg@memberV}{#1}
  \else
     \ClassError{uncgdissertation.cls}
        {Committee error.  Too many members.}
  \fi
}
%-----------------------------------------------------------------------------

%% -------------------------------------------------------------------------- %%
%% Thesis Title
\renewcommand{\title}[1]{\newcommand{\uncg@thesistitle}{#1}}


\newcommand{\student}[2]{
    \newcommand{\uncg@authorfirstmiddle}{#1}
    \newcommand{\uncg@authorlast}{#2}
    \newcommand{\uncg@author}{#1 #2}
    \author{#1 #2}
}

\if@MA{\gdef\@thesis{thesis}
  \gdef\@capthesis{Thesis}
  \gdef\@degree{Master~of~Arts} 
  \gdef\@shortdegree{M.A.}} \else 
\if@MS{\gdef\@thesis{thesis} 
  \gdef\@capthesis{Thesis} 
  \gdef\@degree{Master~of~Science} 
  \gdef\@shortdegree{M.S.}} \else
\if@PHD{\gdef\@thesis{dissertation} 
  \gdef\@capthesis{Dissertation} 
  \gdef\@degree{Doctor~of~Philosophy}
  \gdef\@shortdegree{Ph.D.}} \fi\fi\fi



%% Degree year
\newcommand{\degreeyear}[1]{
    \newcommand{\uncg@year}{#1}
}

\newenvironment{abstract}{%
  \thispagestyle{empty}
  \setcounter{page}{0}
  \noindent
  \MakeUppercase{\uncg@authorlast{},~%
    \uncg@authorfirstmiddle{}},~\@shortdegree~\uncg@thesistitle. (\uncg@year)\\
  Directed by
  \ifthenelse{\value{@chair}=1}{Dr.~\uncg@chair}{Dr.~\uncg@chair\ and
    Dr.~\uncg@cochair}. \pageref{LastPage} pp.\\ 
  %line break above needed to make above singlespace and below
  %doublespace

  \pagestyle{empty}
}%
{\clearpage
\pagestyle{plain}
}


% Length of signature lines and height 
\newlength{\namewidth}
\setlength{\namewidth}{2.8in} % Hard-coded to align start of signature
                            % with first o in Greensboro

%% Line height
\newlength{\uncg@signatureheight}
\setlength{\uncg@signatureheight}{2em}


\newcommand{\uncg@signatureline}[1]{
    \begin{minipage}[t]{\namewidth}
      \underline{\hspace*{\namewidth}}
     \vspace{0.5ex}
     #1
    \end{minipage}
}


\newcommand{\uncg@dateline}[1]{
    \begin{minipage}[t]{\namewidth}
      %\underline{\hspace*{\namewidth}}\\
      \underline{\phantom{#1}}\par
     \vspace{0.5ex}
     #1
    \end{minipage}
}


% This should be switched if more than one chair.
\newcommand{\uncg@chairsignature}{
  \begin{minipage}[t]{\namewidth}
    \ifthenelse{\value{@chair}=1}{
      Approved by\\[\uncg@signatureheight]
      \uncg@signatureline{Committee Chair}
      }{
      Approved by\\[\uncg@signatureheight]
      \uncg@signatureline{Committee Co-Chair}\\[\uncg@signatureheight]
      \uncg@signatureline{Committee Co-Chair}}
  \end{minipage}
}


\newcommand{\uncg@datelines}{
  \begin{minipage}{\namewidth}
    \uncg@dateline{Date of Acceptance by
      Committee}\\[\uncg@signatureheight]
    \uncg@dateline{Date of Final Oral Examination}\\
  \end{minipage}
}

\newcommand{\uncg@chairtable}
{
\ifthenelse{\value{@chair}=1}{
Committee Chair &
\uncg@signatureline{\uncg@chair}\\[\uncg@signatureheight]}
{
Committee Co-Chair &
\uncg@signatureline{\uncg@chair}\\[\uncg@signatureheight]
Committee Co-Chair &
\uncg@signatureline{\uncg@cochair}\\[\uncg@signatureheight]
}
}

\newcommand{\uncg@committeesignatures}{
  \ifthenelse{\value{@member}=2}{
%Come back
    \begin{tabular}[t]{r@{\hspace{2.7pt}}l}%c@{\hspace{0.5in}}c}
      \uncg@chairtable
      Committee Members
      &\uncg@signatureline{\uncg@memberI}\\[\uncg@signatureheight]
       &\uncg@signatureline{\uncg@memberII}
    \end{tabular}
}{} % end ifthenelse = 3

  \ifthenelse{\value{@member}=3}{
    \begin{tabular}[t]{r@{\hspace{2.7pt}}l}%c@{\hspace{0.5in}}c}
\uncg@chairtable
      Committee Members
      &\uncg@signatureline{\uncg@memberI}\\[\uncg@signatureheight]
       &\uncg@signatureline{\uncg@memberII}\\[\uncg@signatureheight]
     &\uncg@signatureline{\uncg@memberIII}
    \end{tabular}
  }{} % end ifthenelse = 4
  
\ifthenelse{\value{@member}=4}{
\begin{tabular}[t]{r@{\hspace{2.7pt}}l}%c@{\hspace{0.5in}}c}
\uncg@chairtable
      Committee Members
      &\uncg@signatureline{\uncg@memberI}\\[\uncg@signatureheight]
       &\uncg@signatureline{\uncg@memberII}\\[\uncg@signatureheight]
     &\uncg@signatureline{\uncg@memberIII}\\[\uncg@signatureheight]
     &\uncg@signatureline{\uncg@memberIV}
    \end{tabular}
}{} % end ifthenelse = 5
  \ifthenelse{\value{@member}=5}{
\begin{tabular}[t]{r@{\hspace{2.7pt}}l}%c@{\hspace{0.5in}}c}
\uncg@chairtable
      Committee Members
      &\uncg@signatureline{\uncg@memberI}\\[\uncg@signatureheight]
       &\uncg@signatureline{\uncg@memberII}\\[\uncg@signatureheight]
     &\uncg@signatureline{\uncg@memberIII}\\[\uncg@signatureheight]
     &\uncg@signatureline{\uncg@memberIV}\\[\uncg@signatureheight]
      &\uncg@signatureline{\uncg@memberV}
    \end{tabular}
}{} % end ifthenelse = 6
}

%% Title page
\newcommand{\maketitlepage}{
  \thispagestyle{empty}  % after chapter* command to ensure no page
                         % numbers.
{%\doublespacing
\centering
    \vspace*{0.5\baselineskip}
  \MakeUppercase{\uncg@thesistitle}
\vspace*{0.5\baselineskip}

    by \par
    \vspace*{0.5\baselineskip}

    \uncg@author \par
    \vspace*{2\baselineskip}
    
    %\singlespacing
   A \@capthesis\ Submitted to \\
  the Faculty of The Graduate School at\\
  The University of North Carolina at Greensboro\\
  in Partial Fulfillment\\
  of the Requirements for the Degree\\
  \@degree\\
}
    \vfill
{\centering
    Greensboro\\
    \uncg@year\par
  }
  \vfill

  \begin{flushright}    \uncg@chairsignature \end{flushright}
  \clearpage
  %\doublespacing
}

%% Copyright page
\newcommand{\makecopyrightpage}{ \addtocounter{page}{-1}
  \thispagestyle{empty} \ \vfill
      \begin{center}
        \copyright{} \uncg@year{} \uncg@author
      \end{center}
      \ \vfill
\clearpage
}


%%  Dedication page
\newenvironment{dedication}
{\setcounter{page}{2} ~\vfill \par \centering \sl}
{ \vfill \par \clearpage}


%%  Acknowledgments page
\newenvironment{acknowledgments}
{
  \begin{center}
    ACKNOWLEDGMENTS
  \end{center}
}
{ \vfill \par \clearpage}


%%  Preface page
\newenvironment{preface}
{\begin{center}
PREFACE  
\end{center}
}
{ \vfill \par \clearpage}

%% Approval page
\newcommand{\makeapprovalpage}{
{\begin{center}APPROVAL PAGE \end{center}}

  This \@thesis\ written by \uncg@author\ has been approved by the
  following committee of the Faculty of The Graduate School at The
  University of North Carolina at Greensboro.
  \vfill
  %\singlespacing
  \begin{center}
    \uncg@committeesignatures
  \end{center}
  \vfill
  \begin{flushleft}
    \uncg@datelines
  \end{flushleft}
  \vfill
%  \doublespacing
  \clearpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% An algorithm environment for typesetting algorithms consistently.  
%% Takes 2 arguments--the input and output.
%% Current plan is to typeset input and output only and switch font to
              %% rm
\newlength{\@alginputwidth}
\setlength{\@alginputwidth}{\textwidth}
\newlength{\@alglspace}
\settowidth{\@alglspace}{\rm Output:}
\addtolength{\@alginputwidth}{-2\@alglspace}
\newenvironment{uncgalgorithm}[2]{%
%Stuff before
\mbox{}
\rm
\begin{itemize}
\item[\rlap{Input:}] \hspace{\@alglspace} \parbox[t]{\@alginputwidth}{#1}
\item
  [\rlap{Output:}] \hspace{\@alglspace} \parbox[t]{\@alginputwidth}{#2}
\end{itemize}
}
{
%Stuff after
\relax
}

