import { Component } from 'react';
import { Section } from '../components';
import { Window } from '../layouts';

const icons = {
  bugfix: { icon: 'bug', color: 'green' },
  fix: { icon: 'bug', color: 'green' },
  wip: { icon: 'hammer', color: 'orange' },
  qol: { icon: 'hand-holding-heart', color: 'green' },
  soundadd: { icon: 'tg-sound-plus', color: 'green' },
  sounddel: { icon: 'tg-sound-minus', color: 'red' },
  add: { icon: 'check-circle', color: 'green' },
  expansion: { icon: 'check-circle', color: 'green' },
  rscadd: { icon: 'check-circle', color: 'green' },
  rscdel: { icon: 'times-circle', color: 'red' },
  imageadd: { icon: 'tg-image-plus', color: 'green' },
  imagedel: { icon: 'tg-image-minus', color: 'red' },
  spellcheck: { icon: 'spell-check', color: 'green' },
  experiment: { icon: 'radiation', color: 'yellow' },
  balance: { icon: 'balance-scale-right', color: 'yellow' },
  code_imp: { icon: 'code', color: 'green' },
  refactor: { icon: 'tools', color: 'green' },
  config: { icon: 'cogs', color: 'purple' },
  admin: { icon: 'user-shield', color: 'purple' },
  server: { icon: 'server', color: 'purple' },
  tgs: { icon: 'toolbox', color: 'purple' },
  tweak: { icon: 'wrench', color: 'green' },
  ui: { icon: 'desktop', color: 'blue' },
  mapadd: { icon: 'earth-africa', color: 'yellow' },
  maptweak: { icon: 'map-location-dot', color: 'green' },
  unknown: { icon: 'info-circle', color: 'label' },
};

export class Changelog extends Component {
  constructor() {
    super();
    this.state = {};
  }

  render() {
    const header = (
      <Section>
        <p>
          Sector Patrol started as a downstream of CM-SS13 and could not have
          existed without the players and the administrative, systems and coding
          staff of CM and the SS13 servers that inspired it, including Bay and
          TG, the code of both of which makes CM, and Sector Patrol, work.
        </p>
        <p>
          <b>Thank you all!</b>
        </p>
        <p>
          Sector Patrols initial incarnation was written and conceived by{' '}
          <b>silencer_pl</b> which includes initial coding work. Sector Patrol,
          like most of what I do, could not be possible without <b>Scarlet.</b>
        </p>
        <p>
          The project would also never have started without the initial
          commitment of <b>Ito</b>, <b>Moonshanks</b>, <b>4hands44</b> and all
          the other misfits and CM refugees that were with us when we started{' '}
          <b>Neroid Sector</b>. I&#39;m sorry I can&#39;t remember all of you by
          name U.U
        </p>
        <p>
          <b>Sector Patrol is part of the Neroid Sector Event Server.</b>
        </p>
        <p>
          <a href={'https://discord.gg/vgr2RWZcXy'}>
            <b>Join our Discord!</b>
          </a>
        </p>
      </Section>
    );

    const footer = (
      <Section>
        <h3>Licencisng information:</h3>
        <p>
          Sector Patrol is currently synced to the{' '}
          <a href="https://github.com/cmss13-devs/cmss13">CM-SS13 codebase</a>,
          with the last commit currently synced listed on top of the changelog
          and under respective licensing.
        </p>
        <p>
          Sector Patrol is avaialbe under{' '}
          <a href="https://github.com/Neroid-Sector/SectorPatrol/blob/master/LICENSE">
            GNU AGPL v3
          </a>
        </p>
        <p>
          All assets including icons and sound are under{' '}
          <a href="https://creativecommons.org/licenses/by-sa/3.0/">
            {' '}
            Creative Commons 3.0 BY-SA license{' '}
          </a>
          unless otherwise indicated.
        </p>
        The TGS DMAPI API is licensed as a subproject under the MIT license.
        {' See the footer of '}
        <a
          href={
            'https://github.com/tgstation/tgstation/blob/master' +
            '/code/__DEFINES/tgs.dm'
          }>
          code/__DEFINES/tgs.dm
        </a>
        {' and '}
        <a
          href={
            'https://github.com/tgstation/tgstation/blob/master' +
            '/code/modules/tgs/LICENSE'
          }>
          code/modules/tgs/LICENSE
        </a>
        {' for the MIT license.'}
      </Section>
    );

    const changes = (
      <Section>
        <h1>
          <center>
            <b>Sector Patrol</b>
          </center>
        </h1>
        <h2>
          <center>
            <b>ALPHA</b>
          </center>
        </h2>
        <h3>
          <center>
            <b>Patch 0</b>
          </center>
        </h3>
        <p>Currently synced up to the following comit on CM-SS13:</p>
        <p>
          <a href="https://github.com/silencer-pl/cmss13/commit/b6f89f3c29301301f4a90ead75746d16ffab26d2">
            b6f89f3
          </a>
        </p>
        <p>
          This patch contains the basic content for the &#39;soft launch&#39; of
          Sector Patrol into an incremental Alpha or however you want to call
          it. This involves a lot of backend changes, and:
        </p>
        <p>- Chargen, the character creation system.</p>
        <p>
          - Modular floors and basic crafting, a system that remembers colors
          and textures of sub elements that come wrapped in various sized
          packages.
        </p>
        <p>
          - Terminals, terminal inputs. This also includes previews of the
          remote briefings system and general &#39;cinematic&#39; sequences.
        </p>
        <p>
          - Puzzle sequences involving terminals, object manipulation via tools,
          environmental searching and terminal/npc prompts.
        </p>
        <p>
          - Several first passes at multiple &#39;locations&#39;, effectively
          scenes for roleplay, spread across the OV-PST.
        </p>
        <p>
          - Lore entries, story hooks and first introductions to the world of
          Sector Patrol and the style of narration/gameplay the game mode
          includes.
        </p>
      </Section>
    );
    return (
      <Window title="Changelog" width={675} height={650}>
        <Window.Content scrollable>
          {header}
          {changes}
          {footer}
        </Window.Content>
      </Window>
    );
  }
}
