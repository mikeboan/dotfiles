import { DateTime } from "luxon";
import type { InviteId, ReadingPairId } from "./ids";

// Case 1: pure deletion — this whole block goes away.
export const LEGACY_TTL_HOURS = 48;
export function legacyExpiry(createdAt: DateTime): DateTime {
  return createdAt.plus({ hours: LEGACY_TTL_HOURS });
}

// Case 2: single-word change inside a line (inline:char vs inline:word).
export const inviteKey = (inviteId: InviteId) => `invite:${inviteId}`;

// Case 3: line modified + lines inserted around it (linematch).
export interface IncomingInviteFacts {
  readonly inviteId: InviteId;
  readonly readingPairId: ReadingPairId;
  readonly expiresAt: DateTime;
}

// Case 4: whitespace-only change (try :set diffopt+=iwhite).
export function isExpired(facts: IncomingInviteFacts, now: DateTime): boolean {
  return facts.expiresAt < now;
}

// Case 5: block that moves to the bottom of the file.
export function describe(facts: IncomingInviteFacts): string {
  return `Invite ${facts.inviteId} for pair ${facts.readingPairId}`;
}

// Case 6: unchanged tail, long enough to show context folding.
export const A = 1;
export const B = 2;
export const C = 3;
export const D = 4;
export const E = 5;
export const F = 6;
export const G = 7;
export const H = 8;
