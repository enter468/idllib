pro colrbar, xbar=xbar, ybar=ybar, position=position, $
      bottom=bottom, top=top, $
      xtitle=xtitle, ytitle=ytitle, $
      xtickformat=xtickformat, ytickformat=ytickformat, $
      noerase=noerase, _extra=extra

  if n_elements(bottom) eq 0 then bottom = 0b
  if n_elements(top) eq 0 then top = 255b
  if n_elements(noerase) eq 0 then noerase = 0b
  if n_elements(xbar) ne 0 and $
    n_elements(ybar) eq 0 then begin

    if n_elements(position) eq 0 then begin
      position = [0.1, .45, .95, .55]
    endif
  endif else if n_elements(xbar) eq 0 and $
    n_elements(ybar) ne 0 then begin

    if n_elements(position) eq 0 then begin
      position = [0.45, .1, .55, .95]
    endif
  endif

  if ~noerase then erase

  x = position[[0, 2]]
  y = position[[1, 3]]
  ipos = convert_coord(x, y, /normal, /to_device)
  ix = round(ipos[[0, 3]])
  iy = round(ipos[[1, 4]])

  if n_elements(xbar) eq 0 and $
    n_elements(ybar) ne 0 then begin

    cbar = replicate(1b, ix[1]-ix[0]) # indgen(iy[1]-iy[0])
    tv, bytscl(cbar, top=top - bottom) + bottom, ix[0], iy[0]
    plot, [0, 1], /nodata, /noerase, position=position, $
      xtickformat='(A1)', /xticks, /xminor, $
      ystyle=4, _extra=extra
    axis, yaxis=ybar, ix[ybar], iy[0], /device, $
      ytitle=ytitle, ytickformat=ytickformat, $
      _extra=extra
    axis, yaxis=~ybar, ix[~ybar], iy[0], /device, $
      ytitle='', ytickformat='(A1)', $
      _extra=extra
  endif else if n_elements(xbar) ne 0 and $
    n_elements(ybar) eq 0 then begin

    cbar = indgen(ix[1]-ix[0]) # replicate(1b, iy[1]-iy[0])
    tv, bytscl(cbar, top=top - bottom) + bottom, ix[0], iy[0]
    plot, [0, 1], /nodata, /noerase, position=position, $
      ytickformat='(A1)', /yticks, /yminor, $
      xstyle=4, _extra=extra
    axis, xaxis=xbar, ix[0], iy[xbar], /device, $
      xtitle=xtitle, xtickformat=xtickformat, $
      _extra=extra
    axis, xaxis=~xbar, ix[0], iy[~xbar], /device, $
      xtitle='', xtickformat='(A1)', $
      _extra=extra
  endif
end
