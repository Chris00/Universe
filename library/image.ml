(* filename : image.ml *)

open Color

(* $B;M3Q7A(B *)
type rect_t = {
  color : Color.t;              (* $B?'(B *)
  x1 : float; y1 : float;       (* $B:8>e$N:BI8(B *)
  x2 : float; y2 : float;       (* $B2#I}!"9b$5(B *)
  fill : bool;                  (* $BEI$j$D$V$7$NM-L5(B *)
  outline_size : float;         (* $B30OH$N%5%$%:(B *)
}

(* $BB?3Q7A(B *)
type polygon_t = {
  color : Color.t;              (* $B?'(B *)
  x : float; y : float;         (* $B:8>e$N0LCV(B *)
  points : (float * float) list;(* $BE@$N:BI8$N%j%9%H(B *)
  fill : bool;                  (* $BEI$j$D$V$7$NM-L5(B *)
  outline_size : float;         (* $B30OH$N%5%$%:(B *)
}


(* $B1_(B *)
type circle_t = {
  color : Color.t;              (* $B?'(B *)
  x1 : float; y1 : float;       (* $BCf?4$N:BI8(B *)
  radious : float;              (* $BH>7B(B *)
  fill : bool;                  (* $BEI$j$D$V$7$NM-L5(B *)
  outline_size : float;         (* $B30OH$N%5%$%:(B *)
}

(* $B@~(B *)
type line_t = {
  color : Color.t;              (* $B?'(B *)
  size : float;                 (* $B@~$N%5%$%:(B *)
  x : float; y : float;         (* $B:8>e$N0LCV(B *)
  points : (float * float) list (* $BE@$N:BI8$N%j%9%H(B *)
}

(* $B%F%-%9%H(B *)
type text_t = {
  color : Color.t;              (* $B?'(B *)
  text : string;                (* $B%F%-%9%H(B *)
  x : float; y : float;         (* $B:82<$N:BI8(B *)
  size : float;                 (* $B%U%)%s%H$N%5%$%:(B *)
}

(* $B2hA|(B *)
type picture_t = {
  picture : Cairo.Surface.t;    (* $B2hA|(B *)
  x : float; y : float;         (* $B:8>e$N:BI8(B *)
}

type t =
    RECT of rect_t
  | POLYGON of polygon_t
  | CIRCLE of circle_t
  | LINE of line_t
  | TEXT of text_t
  | PICTURE of picture_t
  | IMAGE of t list

(* $BAjBP0LCV$N:BI8$N%j%9%H$r@dBP0LCV$N:BI8$N%j%9%H$KJQ$($k(B *)
(* rel_to_ab : (float * float) list -> float * float -> (float * float) list *)
let rec rel_to_ab lst (prex, prey) = match lst with
    [] -> []
  | (x, y) :: rest ->
      let new_posn = (x +. prex, y +. prey) in
      new_posn :: rel_to_ab rest new_posn

(* $B:BI8$N%j%9%H$r<u$1<h$j(B, $B:82<$N:BI8$rJV$9(B *)
(* get_min : (float * float) list -> (float * float) *)
let rec get_min lst (minx, miny) = match lst with
    [] -> (minx, miny)
  | (x, y) :: rest ->
      let nextminx = if minx <= x then minx else x in
      let nextminy = if miny <= y then miny else y in
      get_min rest (nextminx, nextminy)

(* $B%F%-%9%H$H%5%$%:$r<u$1<h$C$?$i2hA|$N2#$H=D$NAH$rJV$9(B *)
(* text_wh : string -> float -> (int * int) *)
let text_wh str size =
  let surface = Cairo.Image.create Cairo.Image.ARGB32 ~width:0 ~height:0 in
  let context = Cairo.create surface in
  begin
    Cairo.set_font_size context size;
    let text_extends = Cairo.text_extents context str in
    match text_extends with
      {Cairo.width = w; Cairo.height = h} -> (w, h)
  end

(* line, polygon $B4X?t$G;H$&(B *)
(* x $B$H(B y $B$=$l$>$l$N:G>.CM$,Ii$N;~$N$_:BI8$rF0$+$9$,(B, $B$=$NCM$rJV$9(B *)
(* move_xy : (float * float) list -> (float : float) *)
let move_xy lst =
  let ab_points = rel_to_ab lst (0., 0.) in (*(0, 0) $B$+$i$N@dBP0LCV(B *)
  let min_posn = get_min ab_points (0., 0.) in (* $B:82<$N:BI8(B *)
  let min_x = fst min_posn in
  let min_y = snd min_posn in
  let move_x = if min_x >= 0. then 0. else min_x in
  let move_y = if min_y >= 0. then 0. else min_y in
  (move_x, move_y)

(* rectangle : float -> float ->
               ?fill:bool -> ?outline_size:float -> Color.t -> Image.t *)
let rectangle w h ?(fill = true) ?(outline_size = 0.) c =
  RECT {color = c; x1 = 0.; y1 = 0.; x2 = w; y2 = h;
        fill = fill; outline_size = outline_size}

(* empty_scene : float -> float -> Image.t *)
let empty_scene w h = rectangle w h Color.white ~fill:true ~outline_size:0.

(* circle : float -> ?fill:bool -> ?outline_size:float -> Color.t -> Image.t *)
let circle r ?(fill = true) ?(outline_size = 0.) c =
  CIRCLE {color = c; x1 = r; y1 = r; radious = r;
          fill = fill; outline_size = outline_size}

(* line : (float * float) list -> ?size:float -> Color.t -> Image.t *)
let line lst ?(size = 0.5) c =
  let movexy = move_xy lst in 
  (* x $B$H(B y $B$=$l$>$l$N:G>.CM$,Ii$N;~$N$_:BI8$rF0$+$9(B *)
  (* line $B$N:82<$r2hA|$N(B (0, 0) $B$K$9$k$?$a(B *)
  LINE {color = c; size = size; x = 0. -. fst movexy; y = 0. -. snd movexy;
        points = lst}

(* polygon : (float * float) list ->
             ?fill:bool -> ?outline_size:float -> Color.t -> Image.t *)
let polygon lst ?(fill = true) ?(outline_size = 0.) c =
  let movexy = move_xy lst in 
  (* x $B$H(B y $B$=$l$>$l$N:G>.CM$,Ii$N;~$N$_:BI8$rF0$+$9(B *)
  (* line $B$N:82<$r2hA|$N(B (0, 0) $B$K$9$k$?$a(B *)
  POLYGON {color = c; x = 0. -. fst movexy; y = 0. -. snd movexy;
           points = lst; fill = fill; outline_size = outline_size}

(* text : string -> ?size:float -> Color.t -> Image.t *)
let text str ?(size = 20.) c =
  let wh = text_wh str size in
  TEXT {color = c; text = str; x = 0.; y = snd wh; size = size}

(* read_image : string -> Image.t *)
let read_image name =
  let pic =
    try
      Cairo.PNG.create name
    with Out_of_memory ->
           failwith ("The file " ^ name ^ " is not PNG.") in
  PICTURE {picture = pic; x = 0.; y = 0.}

(* move_one *)
let rec move_one dx dy pic = match pic with
    RECT {color = c; x1 = x; y1 = y; x2 = w; y2 = h;
          fill = fill; outline_size = outline_size} ->
    RECT {color = c; x1 = x +. dx; y1 = y +. dy; x2 = w; y2 = h;
          fill = fill; outline_size = outline_size}
  | POLYGON {color = c; x = x; y = y; points = lst;
             fill = fill; outline_size = outline_size} ->
    POLYGON {color = c; x = x +. dx; y = y +. dy; points = lst;
             fill = fill; outline_size = outline_size}
  | CIRCLE {color = c; x1 = x; y1 = y; radious = r;
            fill = fill; outline_size = outline_size} ->
    CIRCLE {color = c; x1 = x +. dx; y1 = y +. dy; radious = r;
            fill = fill; outline_size = outline_size}
  | LINE {color = c; size = s; x = x; y = y; points = lst} ->
    LINE {color = c; size = s; x = x +. dx; y = y +. dy; points = lst}
  | TEXT {color = c; text = t; x = x; y = y; size = s} ->
    TEXT {color = c; text = t; x = x +. dx; y = y +. dy; size = s}
  | PICTURE {picture = p; x = x; y = y} ->
    PICTURE {picture = p; x = x +. dx; y = y +. dy}
  | IMAGE lst -> IMAGE (List.map (move_one dx dy) lst)

(* place_images : Image.t list -> (float * float) list -> Image.t -> Image.t *)
let rec place_images pics posns background = match (pics, posns) with
    ([], []) -> background
  | ([], _ :: _) -> failwith "place_images: too many posns."
  | (_ :: _, []) -> failwith "place_images: too many pics."
  | (pic :: pics, (dx, dy) :: posns) ->
    IMAGE (move_one dx dy pic ::
           let background = place_images pics posns background in
           begin match background with
               IMAGE lst -> lst
             | _ -> [background]
           end)

(* place_image : Image.t -> int * int -> Image.t -> Image.t *)
let rec place_image pic posn background =
  place_images [pic] [posn] background

(* rev_iter *)
let rec rev_iter f lst = match lst with
    [] -> ()
  | first :: rest -> rev_iter f rest; f first

(* $B%Q%9$N30OH$rEI$k(B *)
(* draw_outline : Cairo.context -> float -> unit *)
let draw_outline context outline_size =
  Cairo.set_line_width context outline_size;
  Cairo.set_line_cap context Cairo.ROUND; (* $B@~$NC<$r4]$/$9$k(B *)
  Cairo.set_line_join context Cairo.JOIN_ROUND; (* $B@~$N3Q$r4]$/$9$k(B *)
  Cairo.stroke context

(* context $B$K(B line $B$N%Q%9$r:n@.$9$k(B *)
(* draw_line : (float * float) list -> Cairo.context -> unit *)
let rec draw_line plst context = match plst with
    [] -> ()
  | (x, y) :: rest ->
      Cairo.rel_line_to context ~x:x ~y:y;
      draw_line rest context

(* image $B$r(B canvas $B$KIA2h$9$k(B *)
(* draw : Cairo.context -> t -> unit *)
let rec draw context image = match image with
    RECT {color = c; x1 = x; y1 = y; x2 = w; y2 = h;
          fill = fill; outline_size = outline_size} ->
      let (r, g, b, a) = Color.to_rgba c in
      Cairo.set_source_rgba context (float_of_int r) (float_of_int g)
                                    (float_of_int b) (float_of_int a);
      Cairo.rectangle context ~x:x ~y:y ~w:w ~h:h;
      if fill then Cairo.fill_preserve context;(* $BEI$j$D$V$9>l9g(B *)
      draw_outline context outline_size
  | POLYGON {color = c; x = x; y = y; points = lst;
             fill = fill; outline_size = outline_size} ->
      let (r, g, b, a) = Color.to_rgba c in
      Cairo.set_source_rgba context (float_of_int r) (float_of_int g)
                                    (float_of_int b) (float_of_int a);
      Cairo.move_to context x y;
      draw_line lst context;
      Cairo.Path.close context; (* $B:G=i$H:G8e$NE@$r7k$V(B *)
      if fill then Cairo.fill_preserve context;(* $BEI$j$D$V$9>l9g(B *)
      draw_outline context outline_size
  | CIRCLE {color = c; x1 = x; y1 = y; radious = radius;
            fill = fill; outline_size = outline_size} ->
      let pi2 = 8. *. atan 1. in
      let (r, g, b, a) = Color.to_rgba c in
      Cairo.set_source_rgba context (float_of_int r) (float_of_int g)
                                    (float_of_int b) (float_of_int a);
      Cairo.arc context ~x:x ~y:y ~r:radius ~a1:0. ~a2:pi2;
      if fill then Cairo.fill_preserve context;(* $BEI$j$D$V$9>l9g(B *)
      draw_outline context outline_size
  | LINE {color = c; size = s; x = x; y = y; points = lst} ->
      let (r, g, b, a) = Color.to_rgba c in
      Cairo.set_source_rgba context (float_of_int r) (float_of_int g)
                                    (float_of_int b) (float_of_int a);
      Cairo.set_line_width context s;
      Cairo.move_to context x y;
      draw_line lst context;
      Cairo.set_line_cap context Cairo.ROUND; (* $B@~$NC<$r4]$/$9$k(B *)
      Cairo.set_line_join context Cairo.JOIN_ROUND; (* $B@~$N3Q$r4]$/$9$k(B *)
      Cairo.stroke context
  | TEXT {color = c; text = t; x = x; y = y; size = s} ->
      let (r, g, b, a) = Color.to_rgba c in
      Cairo.set_source_rgba context (float_of_int r) (float_of_int g)
                                    (float_of_int b) (float_of_int a);
      Cairo.set_font_size context s;
      Cairo.move_to context x y;
      Cairo.show_text context t;
      Cairo.fill context
  | PICTURE {picture = p; x = x; y = y} ->
      Cairo.set_source_surface context p ~x:x ~y:y;
      Cairo.paint context
  | IMAGE lst -> (* $B8e$m$+$iIA2h(B *)
      rev_iter (draw context) lst

(* $B:82<$H1&>e$N:BI8$N%j%9%H$r<u$1<h$j(B, $B:82<$N:BI8$H1&>e$N:BI8$rJV$9(B *)
(* get_corner_posn : ((float * float) * (float * float)) list
                     -> (float * float) * (float * float) *)
let rec get_corner_posn lst ((minx, miny), (maxx, maxy)) = match lst with
    [] -> ((minx, miny), (maxx, maxy))
  | ((x1, y1), (x2, y2)) :: rest ->
      let nextminx = if minx <= x1 then minx else x1 in
      let nextminy = if miny <= y1 then miny else y1 in
      let nextmaxx = if maxx >= x2 then maxx else x2 in
      let nextmaxy = if maxy >= y2 then maxy else y2 in
      get_corner_posn rest ((nextminx, nextminy), (nextmaxx, nextmaxy))

(* $B:BI8$N%j%9%H$r<u$1<h$j(B, $B:82<$N:BI8$H1&>e$N:BI8$rJV$9(B *)
(* get_min_max : (float * float) list -> ((float * float) * (float * float)) *)
let rec get_min_max lst ((minx, miny), (maxx, maxy)) = match lst with
    [] -> ((minx, miny), (maxx, maxy))
  | (x, y) :: rest ->
      let nextminx = if minx <= x then minx else x in
      let nextminy = if miny <= y then miny else y in
      let nextmaxx = if maxx >= x then maxx else x in
      let nextmaxy = if maxy >= y then maxy else y in
      get_min_max rest ((nextminx, nextminy), (nextmaxx, nextmaxy))

(* $B:82<$N:BI8$rF@$k(B *)
(* lower_left : (float * float) -> float -> (float * float) *)
let lower_left (x, y) distance =
  (x -. distance, y -. distance)

(* $B1&>e$N:BI8$rF@$k(B *)
(* upper_right : (float * float) -> float -> (float * float) *)
let upper_right (x, y) distance =
  (x +. distance, y +. distance)

(* $B30OH$,$"$k?^7A$O@~$NB@$5$NJ,(B, corner_lst $B4X?tFb$G:82<$rF0$+$9I,MW$,$"$k(B *)
(* outline_move : bool -> float-> float *)
let outline_move fill outline_size =
  let half_size = outline_size /. 2. in half_size

(* $BAjBP0LCV$N(B polygon $B$H(B line $B$N(B $B:82<$N:BI8$H1&>e$N:BI8$NAH$rJV$9(B *)
(* make_corner_posn : (float * float) -> (float * float) list ->
                      ((float * float) * (float * float)) list *)
let make_corner_posn (x, y) lst =
  let ab_lst = rel_to_ab lst (x, y) in (* $B@dBP0LCV$KJQ49(B *)
  get_min_max ab_lst ((x, y), (x, y))

(* $B30OH$N(Bpolygon $B$H(B line $B$,(B corner_lst $B4X?t$GJV$9$Y$-CM$r:n$k(B *)
(* $B@~$NB@$5J,(B, $B:82<$H1&>e$N:BI8$rF0$+$9(B *)
(* make_corners : (float * float) * (float * float) -> float ->
                  (((float * float) * float) * (float * float)) list *)
let make_corners (min_posn, max_posn) outline_size =
  let half_size = outline_size /. 2. in
  ((lower_left min_posn half_size, half_size),
   upper_right max_posn half_size)

(* Image.t $B7?$N(B, $BCf$KF~$C$F$$$k2hA|$N:82<$H1&>e$N:BI8$N%j%9%H$rJV$9(B *)
(* $B:82<$N:BI8$,(B line $B$+30OH$K$h$k$b$N$@$HB@$5$NH>J,$,JV$5$l$k(B *)
(* Surface $B$KIA$/:]$K@~$NB@$5J,1&>e$KF0$+$9$?$a(B *)
(* corner_lst : Image.t -> (((float * float) * float) * (float * float)) list *)
let rec corner_lst image =
  match image with
    RECT {color = c; x1 = x; y1 = y; x2 = w; y2 = h;
          fill = fill; outline_size = outline_size} :: rest ->
      let move = outline_move fill outline_size in
      (((x -. move, y -. move), move), (x +. w +. move, y +. h +. move))
      :: corner_lst rest
  | POLYGON {color = c; x = x; y = y; points = lst;
             fill = fill; outline_size = outline_size} :: rest ->
      let min_max = make_corner_posn (x, y) lst in
      make_corners min_max outline_size :: corner_lst rest
      (* $B@~$NB@$5$NJ,(B, $B:82<$H1&>e$N:BI8$rF0$+$9(B *)
  | CIRCLE {color = c; x1 = x; y1 = y; radious = r;
            fill = fill; outline_size = outline_size} :: rest ->
      let move = outline_move fill outline_size in
      (((x -. r -. move, y -. r -. move), move),
       (x +. r +. move, y +. r +. move)) :: corner_lst rest
  | LINE {color = c; size = s; x = x; y = y; points = lst} :: rest ->
      let min_max = make_corner_posn (x, y) lst in
      (* $B:82<$N:BI8$H1&>e$N:BI8$NAH$rF@$k(B *)
      make_corners min_max s :: corner_lst rest
      (* $B@~$NB@$5$NJ,(B, $B:82<$H1&>e$N:BI8$rF0$+$9(B *)
  | TEXT {color = c; text = t; x = x; y = y; size = s} :: rest ->
      let wh = text_wh t s in
      (((x, y), 0.), (x +. fst wh, y +. snd wh)) :: corner_lst rest
  | PICTURE {picture = p; x = x; y = y} :: rest ->
      (((x, y), 0.), (x +. float_of_int (Cairo.Image.get_width p),
                      y +. float_of_int (Cairo.Image.get_height p)))
      :: corner_lst rest
  | (IMAGE lst) :: _ -> corner_lst lst
      (* IMAGE $B$O(B [IMAGE] $B$H$$$&%j%9%H$K$7$FEO$5$l$k(B*)
  | [] -> []

(* Image.t $B$r(BSurface.t $B$K$9$k$H6&$K(B, $BG[CV$9$k$H$-$KF0$+$95wN%$rJV$9(B *)
(* line $B$OB@$5$NJ,Bg$-$/2hA|$r:n$k$?$a(B, $BG[CV$9$k;~$K%^%$%J%9$7$F$"$2$k$+$i(B *)
(* image_to_surface : Image.t -> (Cairo.Surface.t * float) *)
let image_to_surface image =
  let posnlst = corner_lst [image] in
  let corners = get_corner_posn (List.tl posnlst) (List.hd posnlst) in
  (* image $B$N:82<$H1&>e$N:BI8$NAH$rF@$k(B *)
  let minx = fst (fst (fst corners)) in
  let miny = snd (fst (fst corners)) in
  let maxx = fst (snd corners) in
  let maxy = snd (snd corners) in
  let surface = Cairo.Image.create Cairo.Image.ARGB32
                                   ~width:(int_of_float (maxx -. minx))
                                   ~height:(int_of_float (maxy -. miny)) in
  let context = Cairo.create surface in
  let move_distance = snd (fst corners) in
  (* $B:82<$N:BI8$,(B line $B$N$b$N$@$H$3$l$K(B0.$B0J30$NCM$,F~$k(B*)
  draw context (move_one move_distance move_distance image);
  (surface, move_distance)

(* image_to_bitmap : Image.t -> data32 *)
let image_to_bitmap image =
  Cairo.Image.get_data32 (fst (image_to_surface image))

(* bitmap_to_image : data32 -> Image.t *)
let bitmap_to_image data =
  PICTURE {picture = Cairo.Image.create_for_data32 data; x = 0.; y = 0.}

(* freeze : Image.t -> Image.t *)
let freeze image =
  let surface_pair = image_to_surface image in
  let move_distance = 0. -. snd surface_pair in
  PICTURE {picture = fst surface_pair; x = move_distance; y = move_distance}
  (* $B:82<$,(B line $B$N:BI8$@$H$=$NJ,8e$m$K2<$,$C$FG[CV$9$kI,MW$,$"$k(B *)
