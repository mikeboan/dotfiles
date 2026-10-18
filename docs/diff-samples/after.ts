import { DateTime } from "luxon";
import type { InviteId, ReadingPairId } from "./ids";
import type { InteractionKey } from "./queue";

/**
 * Case 0: comment-heavy pure addition — the readability case from the
 * screenshot. Comments are the lowest-contrast syntax group, so this is
 * where a too-strong DiffAdd background hurts most.
 */

// Case 2: single-word change inside a line (inline:char vs inline:word).
export const inviteKey = (inviteId: InviteId): InteractionKey => `invite:${inviteId}`;

// Case 3: line modified + lines inserted around it (linematch).
export interface IncomingInviteFacts {
  readonly inviteId: InviteId;
  readonly readingPairId: ReadingPairId;
  /** Which side opened it — decides who the invite is addressed to. */
  readonly direction: "incoming" | "outgoing";
  readonly littleOneName: string | null;
  readonly expiresAt: DateTime.Utc;
  readonly createdAt: DateTime.Utc;
}

// Case 4: whitespace-only change (try :set diffopt+=iwhite).
export function isExpired(facts: IncomingInviteFacts,  now: DateTime): boolean {
    return facts.expiresAt < now;
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

// Case 5: block that moves to the bottom of the file.
export function describe(facts: IncomingInviteFacts): string {
  return `Invite ${facts.inviteId} for pair ${facts.readingPairId}`;
}
