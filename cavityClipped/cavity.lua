-- An example of cavity, as found in
-- Sections 2.1.9 and 2.1.10 of the OpenFOAM manual.
--
--             BC=w-01
--          c-----------d
--          |           |
--  BC=w-00 |           | BC=w-00
--          |           |
--          |           |
--          |           |
--          a-----------b
--             BC=w-00
--
-- Authors: IJ and RJG
-- Date: 2020-08-30

-- Global settings go first
axisymmetric = false
turbulence_model = "laminar" -- other option is: "k-epsilon" / "laminar"

-- Corners of blocks
a = Vector3:new{x=0.0, y=0.0}
b = Vector3:new{x=1.0, y=0.0}
c = Vector3:new{x=0.0, y=1.0}
d = Vector3:new{x=1.0, y=1.0}

-- Lines connecting blocks.
ab = Line:new{p0=a, p1=b}  -- horizontal line (lowest level)
cd = Line:new{p0=c, p1=d}  -- horizontal linw (top level)
ac = Line:new{p0=a, p1=c}  -- vertical lines (left)
bd = Line:new{p0=b, p1=d}  -- vertical lines (right)

-- Define patches (which are parametric surfaces, no discretisation at this point.)
quad0 = CoonsPatch:new{north=cd, east=bd, south=ab, west=ac}

-- Define grids. Here's where discretisation is added to a Patch
nx0cells = 12
ny0cells = 12
grid0 = StructuredGrid:new{psurface=quad0, niv=nx0cells+1, njv=ny0cells+1}

-- Lastly, define the blocks.
blk0 = FoamBlock:new{grid=grid0, 
		     bndry_labels={west="w-01", south="w-01", east="w-01", north="w-00"}}