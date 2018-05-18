#!/bin/bash -eux
if [[ $HARDENING  =~ true || $HARDENING =~ 1 || $HARDENING =~ yes ]]
then
  if grep '^SHA_CRYPT_MIN_ROUNDS' /tmp/login.defs >/dev/null
  then
    sed -i '/^SHA_CRYPT_MIN/c\SHA_CRYPT_MIN_ROUNDS 65536' /tmp/login.defs
  elif grep '^#\ *SHA_CRYPT_MIN_ROUNDS' /tmp/login.defs
  then
    sed -i '/^#\ *SHA_CRYPT_MIN/c\SHA_CRYPT_MIN_ROUNDS 65536' /tmp/login.defs
  else
    echo 'SHA_CRYPT_MIN_ROUNDS 65536' >> /tmp/login.defs
  fi

  if grep '^ENCRYPT_METHOD' /tmp/login.defs >/dev/null
  then
    sed -i '/^ENCRYPT_METHOD/c\ENCRYPT_METHOD SHA512' /tmp/login.defs
  elif grep '^#\ *ENCRYPT_METHOD' /tmp/login.defs
  then
    sed -i '/^#\ *ENCRYPT_METHOD/c\ENCRYPT_METHOD SHA512' /tmp/login.defs
  else
    echo 'ENCRYPT_METHOD SHA512' >> /tmp/login.defs
  fi

  sed -i '/^SHA_CRYPT_MAX_ROUNDS/d' /tmp/login.defs

  sed -i '/pam_unix.so/c\password        [success=1 default=ignore]      pam_unix.so obscure sha512 rounds=65536' /etc/pam.d/common-password
fi
