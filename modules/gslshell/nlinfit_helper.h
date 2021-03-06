
/* solver-impl.c
 * 
 * Copyright (C) 2009 Francesco Abbate
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */

#ifndef SOLVER_IMPL_H
#define SOLVER_IMPL_H

#include "defs.h"

#include <lua.h>
#include <gsl/gsl_vector.h>

extern size_t
check_positive_arg (lua_State *L, const char *name, const char *fullname);

extern void
solver_get_n_and_p (lua_State *L, size_t *n, size_t *p);

extern void
solver_get_x0 (lua_State *L, gsl_vector_view *x0, size_t p);

#endif
