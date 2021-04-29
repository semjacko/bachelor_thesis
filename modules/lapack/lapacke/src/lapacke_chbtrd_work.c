/*****************************************************************************
  Copyright (c) 2011, Intel Corp.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Intel Corporation nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
  THE POSSIBILITY OF SUCH DAMAGE.
*****************************************************************************
* Contents: Native middle-level C interface to LAPACK function chbtrd
* Author: Intel Corporation
* Generated November, 2011
*****************************************************************************/

#include "lapacke_utils.h"

lapack_int LAPACKE_chbtrd_work( int matrix_order, char vect, char uplo,
                                lapack_int n, lapack_int kd,
                                lapack_complex_float* ab, lapack_int ldab,
                                float* d, float* e, lapack_complex_float* q,
                                lapack_int ldq, lapack_complex_float* work )
{
    lapack_int info = 0;
    if( matrix_order == LAPACK_COL_MAJOR ) {
        /* Call LAPACK function and adjust info */
        LAPACK_chbtrd( &vect, &uplo, &n, &kd, ab, &ldab, d, e, q, &ldq, work,
                       &info );
        if( info < 0 ) {
            info = info - 1;
        }
    } else if( matrix_order == LAPACK_ROW_MAJOR ) {
        lapack_int ldab_t = MAX(1,kd+1);
        lapack_int ldq_t = MAX(1,n);
        lapack_complex_float* ab_t = NULL;
        lapack_complex_float* q_t = NULL;
        /* Check leading dimension(s) */
        if( ldab < n ) {
            info = -7;
            LAPACKE_xerbla( "LAPACKE_chbtrd_work", info );
            return info;
        }
        if( ldq < n ) {
            info = -11;
            LAPACKE_xerbla( "LAPACKE_chbtrd_work", info );
            return info;
        }
        /* Allocate memory for temporary array(s) */
        ab_t = (lapack_complex_float*)
            LAPACKE_malloc( sizeof(lapack_complex_float) * ldab_t * MAX(1,n) );
        if( ab_t == NULL ) {
            info = LAPACK_TRANSPOSE_MEMORY_ERROR;
            goto exit_level_0;
        }
        if( LAPACKE_lsame( vect, 'u' ) || LAPACKE_lsame( vect, 'v' ) ) {
            q_t = (lapack_complex_float*)
                LAPACKE_malloc( sizeof(lapack_complex_float) *
                                ldq_t * MAX(1,n) );
            if( q_t == NULL ) {
                info = LAPACK_TRANSPOSE_MEMORY_ERROR;
                goto exit_level_1;
            }
        }
        /* Transpose input matrices */
        LAPACKE_chb_trans( matrix_order, uplo, n, kd, ab, ldab, ab_t, ldab_t );
        if( LAPACKE_lsame( vect, 'u' ) || LAPACKE_lsame( vect, 'v' ) ) {
            LAPACKE_cge_trans( matrix_order, n, n, q, ldq, q_t, ldq_t );
        }
        /* Call LAPACK function and adjust info */
        LAPACK_chbtrd( &vect, &uplo, &n, &kd, ab_t, &ldab_t, d, e, q_t, &ldq_t,
                       work, &info );
        if( info < 0 ) {
            info = info - 1;
        }
        /* Transpose output matrices */
        LAPACKE_chb_trans( LAPACK_COL_MAJOR, uplo, n, kd, ab_t, ldab_t, ab,
                           ldab );
        if( LAPACKE_lsame( vect, 'u' ) || LAPACKE_lsame( vect, 'v' ) ) {
            LAPACKE_cge_trans( LAPACK_COL_MAJOR, n, n, q_t, ldq_t, q, ldq );
        }
        /* Release memory and exit */
        if( LAPACKE_lsame( vect, 'u' ) || LAPACKE_lsame( vect, 'v' ) ) {
            LAPACKE_free( q_t );
        }
exit_level_1:
        LAPACKE_free( ab_t );
exit_level_0:
        if( info == LAPACK_TRANSPOSE_MEMORY_ERROR ) {
            LAPACKE_xerbla( "LAPACKE_chbtrd_work", info );
        }
    } else {
        info = -1;
        LAPACKE_xerbla( "LAPACKE_chbtrd_work", info );
    }
    return info;
}
